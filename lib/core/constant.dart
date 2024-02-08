import 'package:payment/core/utils/cache_helper.dart';
import 'package:permission_handler/permission_handler.dart';

String token = CacheHelper.getData(key: 'uid') ?? '';
String image =
    'https://firebasestorage.googleapis.com/v0/b/eelu-3c8a8.appspot.com/o/users%2Ficons8-user-100.png?alt=media&token=d118cf02-9a0d-461c-82f0-c0355b8ebb7a';

Future<void> askPermissions() async {
  await askNotificationPermission();
}


Future<void> askNotificationPermission() async {
  var status = await Permission.notification.status;
  if (status.isDenied) {
    await Permission.notification.request();
  }
}
