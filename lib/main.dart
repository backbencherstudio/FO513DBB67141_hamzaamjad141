import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'core/routes/part_of_import.dart';
import 'core/services/payment_services/stripe_services.dart';
import 'core/theme/theme.dart';

// Local notifications plugin instance
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Stripe
  await StripeServices.instance.initialize();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Local Notifications
  const AndroidInitializationSettings androidInitSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initSettings =
  InitializationSettings(android: androidInitSettings);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  /// set device orientation to portraitUp during app running
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// ensuring screen size for screen util package
  await ScreenUtil.ensureScreenSize();

  // Run app
  runApp(const ProviderScope(child: MyApp()));

  // Transparent status bar & nav bar styling
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const double deviceWidth = 375.0;
  static const double deviceHeight = 812.0;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(deviceWidth, deviceHeight),
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Aviation',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          darkTheme: AppTheme.darkTheme,
          routerConfig: RouteConfig().goRouter,
        );
      },
    );
  }
}
