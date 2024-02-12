import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {

    streamController.add(notificationResponse);
  }

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: DarwinInitializationSettings());
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  Future<void> showDownloadProgressNotification(String progress) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'download_progress_notification_channel', 'Download Progress',
        importance: Importance.high,
        priority: Priority.max,
        onlyAlertOnce: true,
        icon: '@mipmap/launcher_icon');
    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await _notificationsPlugin.show(
      1,
      'Download Progress',
      'Progress: $progress',
      notificationDetails,
    );
  }

  Future<void> showDownloadSuccessNotification(String name) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'download_success_notification_channel', 'Download Success',
        importance: Importance.max,
        priority: Priority.max,
        onlyAlertOnce: true,
        icon: '@mipmap/launcher_icon');
    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await _notificationsPlugin.show(
      2,
      'Download Success',
      'download file $name successfully',
      notificationDetails,
    );
  }

  Future<void> showNotification(String title, String? body) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'add_success_notification_channel', 'AddSuccess',
        importance: Importance.high,
        priority: Priority.high,
        onlyAlertOnce: true,
        icon: '@mipmap/launcher_icon');
    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await _notificationsPlugin.show(
      3,
      title,
      body,
      notificationDetails,
    );
  }
}
