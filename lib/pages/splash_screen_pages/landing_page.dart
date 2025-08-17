import 'package:eproject_sem4/pages/auth_pages/signin_page.dart';
import 'package:flutter/material.dart';

import '../../components/general_components/G_Navigation.dart';
import '../../components/general_components/buttons_component.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // big column for the landing page
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // image
                Image.asset('assets/images/harbor_landing.png'),
                // this will be replaced with an image later
                // text
                Text(
                  'Welcome to Laptop Harbor',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // subtext
                Text(
                  "Where quality laptops dock for less."
                  "Explore our curated collection of premium devices.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),
                // button
                MyButton(
                  text: 'get started ',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  },
                ),
                // if signed or not link
              ],
            ),
          ),
    );
  }
}
