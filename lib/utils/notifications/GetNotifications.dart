import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}

  static Future Initialize() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("logo"),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onTap,
        onDidReceiveNotificationResponse: onTap);
  }

  static void showNotification(String title, String body) async {
    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
      "1",
      "Job Application Updates",
      importance: Importance.max,
      priority: Priority.high,
    ));
    await flutterLocalNotificationsPlugin.show(0, title, body, details);
  }
}
