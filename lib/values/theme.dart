import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/values/strings/typography.dart';

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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
      ),
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     textStyle: TextStyle(
    //       fontSize: 12.0,
    //     ),
    //   ),
    // ),
    textTheme: CustomTypography.theme,
    fontFamily: "PlayfairDisplay",
  );
}