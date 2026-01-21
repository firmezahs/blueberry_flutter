import 'dart:io';

import 'package:blueberry/main.dart';
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

    // 3️⃣ Get FCM token (SAFE NOW)
    await _getAndStoreFcmToken();

    // 4️⃣ Token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      log('🔄 FCM Token refreshed: $newToken');
      appStore.setFcmToken(newToken);
    });

    // 5️⃣ Foreground messages
    FirebaseMessaging.onMessage.listen(_onMessage);

    // 6️⃣ Notification tap (background/terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);
  }

  Future<void> _getAndStoreFcmToken() async {
    final token = await _messaging.getToken();
    log('✅ FCM Token: $token');
    appStore.setFcmToken(token, isInitializing: true);
  }

  void _onMessage(RemoteMessage message) {
    log('📩 Foreground message received');

    if (message.notification != null) {
      LocalNotificationService.instance.showNotification(title: message.notification!.title.validate(), body: message.notification!.body.validate());
    }
  }

  void _onMessageOpened(RemoteMessage message) {
    log('📬 App opened from notification: ${message.data}');
    // Handle navigation here
  }
}
