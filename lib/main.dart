import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laborlink/theme/theme_helper.dart';
import 'package:laborlink/routes/app_routes.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDrRniVXhlc64AD4U2IPzO-m8IW_fztbYE",
      appId: "1:64146244942:android:b8b45b69e828dda64fca1f",
      messagingSenderId: "64146244942",
      projectId: "ipdproject-d762c",
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      title: 'hired',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeContainerScreen,
      routes: AppRoutes.routes,
    );
  }
}
