

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ToggleThemeData {
  static Color white = Colors.white;
  static Color BlackMatte = Color(0xff28282B);
  static Color BlackMatteLight = Color(0xff303034); //option two
  static Color WhiteMatte = Color(0xffF2F3F4);
  static const Color smookeyWhite=Color(0xffF1F1F1);
  static Color backgroundSmookyBlack = Color(0xff242424);
  static Color backgroundBlack = BlackMatteLight; // Main Background Color
  static Color darkThemeBackground =
      BlackMatte;
  static Color black = Colors.black;
  static const Color textbordercolor=Color(0xffDEDEDE);
  static Color backgroundWhite = Color(0xffF5F5F5);


  static const Color Appcolor = Color(0xff6978FF);
  static const Color purple = Color(0xff8274FD);


  static Color GreyShade = Colors.grey.shade200;
  static Color grey = Colors.grey;


  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: ToggleThemeData.white),
    primaryColor: ToggleThemeData.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ToggleThemeData.white,
      surfaceTintColor: ToggleThemeData.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Appcolor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme:
    BottomNavigationBarThemeData(backgroundColor: ToggleThemeData.white),
    canvasColor: ToggleThemeData.white,
    primaryColorLight: ToggleThemeData.white,
    cardColor: ToggleThemeData.white,
    shadowColor: Colors.white,
    cardTheme: const CardTheme(color: Colors.white),
    iconTheme: IconThemeData(color: ToggleThemeData.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ToggleThemeData.black,
        backgroundColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ToggleThemeData.black,
        backgroundColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ToggleThemeData.black,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: ToggleThemeData.black,
      unselectedLabelColor: Colors.grey,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: ToggleThemeData.black, fontSize: 16),
      titleLarge: TextStyle(
        color: ToggleThemeData.black,
      ),
      labelLarge: TextStyle(color: ToggleThemeData.black, fontSize: 12),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );


}
