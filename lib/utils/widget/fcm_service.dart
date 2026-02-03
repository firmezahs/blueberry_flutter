import 'dart:convert';
import 'dart:io';

import 'package:blueberry/main.dart';
import 'package:blueberry/view/alerts/alert_screen.dart';
import 'package:blueberry/view/auth/controller/auth_api_controller.dart';
import 'package:blueberry/utils/widget/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nb_utils/nb_utils.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._();
  static final FirebaseMessagingService instance = FirebaseMessagingService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // 1️⃣ Ask permission
    final settings = await _messaging.requestPermission(alert: true, badge: true, sound: true);

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      log('❌ Notification permission denied');
      return;
    }

    // 2️⃣ Wait for APNS token (iOS FIX)
    if (Platform.isIOS) {
      String? apnsToken;
      for (int i = 0; i < 5; i++) {
        apnsToken = await _messaging.getAPNSToken();
        if (apnsToken != null) break;
        await Future.delayed(const Duration(seconds: 1));
      }

      if (apnsToken == null) {
        log('❌ APNS token not available');
        return;
      }

      log('✅ APNS Token: $apnsToken');
    }

    // 3️⃣ Get FCM token
    await _getAndStoreFcmToken();

    // 4️⃣ Token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      log('🔄 FCM Token refreshed: $newToken');
      appStore.setFcmToken(newToken);
      if (userStore.isLoggedIn.validate()) {
        AuthApiController.updateTokenApi(request: {"device_token": newToken});
      }
    });

    // 5️⃣ Check for initial message (if app was terminated)
    _messaging.getInitialMessage().then((message) {
      if (message != null) {
        log('🏁 App launched from notification (terminated state)');
        _handleNotificationNavigation(message.data);
      }
    });

    // 6️⃣ Foreground messages
    FirebaseMessaging.onMessage.listen(_onMessage);

    // 7️⃣ Notification tap (background)
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);
  }

  Future<void> _getAndStoreFcmToken() async {
    final token = await _messaging.getToken();
    log('✅ FCM Token: $token');
    appStore.setFcmToken(token, isInitializing: true);
    
    // Sync to server if already logged in
    if (userStore.isLoggedIn.validate() && token != null) {
      AuthApiController.updateTokenApi(request: {"device_token": token});
    }
  }

  void _onMessage(RemoteMessage message) {
    log('📩 Foreground message received');

    if (message.notification != null) {
      LocalNotificationService.instance.showNotification(
        title: message.notification!.title.validate(),
        body: message.notification!.body.validate(),
        payload: jsonEncode(message.data),
      );
    }
  }

  void _onMessageOpened(RemoteMessage message) {
    log('📬 App opened from notification: ${message.data}');
    _handleNotificationNavigation(message.data);
  }

  void onLocalNotificationTab(String payload) {
    log('📬 Local notification tapped: $payload');
    try {
      final Map<String, dynamic> data = jsonDecode(payload);
      _handleNotificationNavigation(data);
    } catch (e) {
      log('❌ Failed to parse local notification payload: $e');
    }
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    if (!userStore.isLoggedIn.validate()) {
      log('🚫 User not logged in, skipping notification navigation');
      return;
    }

    // Example payload handling: {"type": "order", "id": "123"}
    // For now, let's just go to the notification screen as a default
    NotificationScreen().launch(getContext, pageRouteAnimation: PageRouteAnimation.Slide);
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log(' 处理后台消息: ${message.data}');
    if (message.notification != null) {
      LocalNotificationService.instance.showNotification(
        title: message.notification!.title.validate(),
        body: message.notification!.body.validate(),
        payload: jsonEncode(message.data),
      );
    }
  }
}
