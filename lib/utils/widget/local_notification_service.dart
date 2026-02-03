import 'package:blueberry/utils/widget/fcm_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);

    const settings = InitializationSettings(android: android, iOS: ios);
    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          // You might need to parse the payload back to a Map or handle it based on your logic
          // For now, let's trigger the central navigation logic
          FirebaseMessagingService.instance.onLocalNotificationTab(response.payload!);
        }
      },
    );
  }

  Future<void> showNotification({required String title, required String body, String? payload}) async {
    const android = AndroidNotificationDetails('default_channel', 'General Notifications', channelDescription: 'App notifications', importance: Importance.high, priority: Priority.high);

    const ios = DarwinNotificationDetails();

    const details = NotificationDetails(android: android, iOS: ios);

    await _plugin.show(id: DateTime.now().millisecondsSinceEpoch ~/ 1000, title: title, body: body, notificationDetails: details, payload: payload);
  }
}
