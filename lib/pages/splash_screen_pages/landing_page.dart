import 'package:eproject_sem4/components/general_components/buttons_component.dart';
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
            // this will be replaced with an image later
            // text
            // subtext
            // button
            MyButton(text: 'get started ' , onPressed: (){},)
            // if signed or not link
          ],


        ),
      ),

    );
  }
}
