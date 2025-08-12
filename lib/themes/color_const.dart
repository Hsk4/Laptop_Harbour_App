import 'package:flutter/material.dart';

// Your color constants
const Color primary = Color(0xFFFF4647); // Primary color
const Color buttonColor = Color(0xFFFF4647); // Color for buttons
const Color iconsColor = Color(0xFFFF4548); // Color for icons
const Color specialText = Color(0xFFFF4647); // Color for special text
const Color backgroundColor = Color(0xFFFF4647); // Background color
const Color textColor = Color(0xFF000000); // Default text color
const String fontFamily = "Mona Sans";

final ThemeData mytheme = ThemeData(
  // This is the most important part!
  // The ColorScheme should be fully defined.
  colorScheme: const ColorScheme.light(
    primary: primary, // This sets the button background color
    onPrimary: Colors.white, // This sets the text color for the button
    background: backgroundColor,
    onBackground: textColor,
    // Add other colors here as needed
  ),

  // Set text theme
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: fontFamily),
    bodyMedium: TextStyle(fontFamily: fontFamily),
    // You can also define other text styles here
  ),

  // Set icon theme
  iconTheme: const IconThemeData(
    color: iconsColor,
  ),

  // Define a theme for all ElevatedButton widgets
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // The background color for the button
      backgroundColor: primary,
      // The color of the text/icon on the button
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
  ),

  // This is the deprecated primaryColor property, less important for M3
  primaryColor: primary,

  // Set the global background color for the scaffold
  scaffoldBackgroundColor: backgroundColor,

  // IMPORTANT: Set this to true to use Material 3
  useMaterial3: true,
);