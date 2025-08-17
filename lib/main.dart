import 'package:eproject_sem4/pages/auth_pages/auth_wrapper.dart';
import 'package:eproject_sem4/pages/auth_pages/signin_page.dart';
import 'package:eproject_sem4/pages/splash_screen_pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  // Import Riverpod
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';  // Import Firebase core package
import 'firebase_options.dart'; // Import your generated Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Required for web and all platforms
  );

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),  // Your design size for scaling
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          routes: {
            '/signin_page': (context) => const SignInPage(),
            // ... other routes
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: const LandingPage(),  // Use AuthWrapper here for authentication-based routing
        );
      },
    );
  }
}
