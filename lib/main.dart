// ignore_for_file: depend_on_referenced_packages
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/constant.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/bloc_observer.dart';
import 'package:payment/core/utils/cache_helper.dart';
import 'package:payment/core/utils/notifications.dart';
import 'package:payment/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

  LocalNotificationService localNotificationService = LocalNotificationService();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(
     _firebaseMessagingBackgroundHandler);

  localNotificationService.tokenHandler();

  await CacheHelper.init();
  await askPermissions();
  if (uid == 'mNZIW2lfvSduqyB7Mz8oN80zyIo1') {
    admin = true;
  }
  runApp(const MyApp());
  Bloc.observer = MyBlocObserver();
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
