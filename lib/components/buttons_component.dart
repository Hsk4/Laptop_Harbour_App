import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const MyButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 14.0), // wider for pill shape
        decoration: BoxDecoration(
          color: Color(0xFFFF3B30), // exact red from image
          borderRadius: BorderRadius.circular(30.0), // rounded pill shape
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0, // slightly bigger font for prominence
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
