import 'package:eproject_sem4/components/general_components/G_Navigation.dart';
import 'package:eproject_sem4/pages/splash_screen_pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 // Import Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod

void main() {
  runApp(
    // Wrap the entire app with ProviderScope to enable Riverpod
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Your design size for scaling
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: child,  // Will be GNavigation()
        );
      },
      child: const LandingPage(), // Your app's starting widget
    );
  }
}
