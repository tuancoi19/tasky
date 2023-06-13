import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification
  static Future<void> initializeNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    //_configureLocalTimeZone();
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      macOS: null,
      linux: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(
    String title,
    String desc,
    DateTime dateTime,
    int id,
  ) {
    if (title.isEmpty || desc.isEmpty) {
      return;
    }

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      tag: 'notification',
      importance: Importance.high,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
      linux: null,
    );

    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);

    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      desc,
      scheduledAt,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'Ths s the data',
    );
    log('add noti scucces');
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id, tag: 'notification');
    log('cancel noti scucces');
  }

  Future<void> cancelNotificationsById(int id) async {
    var appNotifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    for (var notification in appNotifications) {
      if (notification.id == id) {
        await flutterLocalNotificationsPlugin.cancel(notification.id);
      }
    }
  }
}
