import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';

class CustomTheme {
  static ThemeData themeData = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorTheme.primaryBlack,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorTheme.primaryRed,
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //
    //   ),
    // ),
    fontFamily: "PlayfairDisplay",
  );
}