import 'package:eproject_sem4/components/G_Navigation.dart';
import 'package:eproject_sem4/pages/Dashboard_pages/main_page.dart';
import 'package:eproject_sem4/pages/location_page/permissions.dart';
import 'package:eproject_sem4/pages/splash_screen_pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eproject_sem4/pages/location_page/location.dart';
import 'package:eproject_sem4/pages/location_page/permissions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Adjusted design size for better scaling
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: child,
        );
      },
      child: location(), // landing page
    );
  }
}
