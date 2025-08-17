
import 'package:eproject_sem4/components/general_components/G_Navigation.dart';
import 'package:eproject_sem4/pages/Dashboard_pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signin_page.dart';  // Make sure this import matches your file name


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          // User is signed in
          return const GNavigation();
        } else {
          // User is not signed in
          return const SignInPage();  // Changed from SigninPage to SignInPage
        }
      },
    );
  }
}