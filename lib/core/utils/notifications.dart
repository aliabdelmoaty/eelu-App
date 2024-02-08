import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static int _notificationId = 0;

  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: null, macOS: null);
    await _notificationsPlugin.initialize(initializationSettings);
    (details) {
      if (details.input != null) {
        
      }
    };
  }

  Future<void> showDownloadProgressNotification(String progress) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'download_progress_notification_channel', 'Download Progress',
        importance: Importance.low,
        priority: Priority.low,
        onlyAlertOnce: true,
        icon: '@mipmap/launcher_icon');
    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await _notificationsPlugin.show(
      _notificationId,
      'Download Progress',
      'Progress: $progress',
      notificationDetails,
    );
  }

  Future<void> showDownloadSuccessNotification(String name) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'download_success_notification_channel', 'Download Success',
        importance: Importance.low,
        priority: Priority.low,
        onlyAlertOnce: true,
        icon: '@mipmap/launcher_icon');
    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await _notificationsPlugin.show(
      _notificationId++,
      'Download Success',
      'download file $name successfully',
      notificationDetails,
    );
  }

  
}
