import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);

    const settings = InitializationSettings(android: android, iOS: ios);
    await _plugin.initialize(settings);
  }

  Future<void> showNotification({required String title, required String body, String? payload}) async {
    const android = AndroidNotificationDetails('default_channel', 'General Notifications', channelDescription: 'App notifications', importance: Importance.high, priority: Priority.high);

    const ios = DarwinNotificationDetails();

    const details = NotificationDetails(android: android, iOS: ios);

    await _plugin.show(DateTime.now().millisecondsSinceEpoch ~/ 1000, title, body, details, payload: payload);
  }
}
