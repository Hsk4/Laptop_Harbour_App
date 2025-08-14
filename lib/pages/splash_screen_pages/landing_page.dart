import 'package:eproject_sem4/components/buttons_component.dart';
import 'package:flutter/material.dart';

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
                  "Welcome to Laptop Harbor",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                // subtext
                Text("Where quality laptops dock for less."
                    "Explore our curated collection of premium devices."),

                // button
                MyButton(text: 'get started ', onPressed: () {}),
                // if signed or not link
              ],
            ),
          ),
    );
  }
}
