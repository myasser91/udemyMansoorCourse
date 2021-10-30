// ignore_for_file: prefer_const_constructors
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messenger/shared/components/constants.dart';

class AppTheme {
  static ThemeData apptheme = ThemeData(
    primarySwatch: defaultColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.redAccent),
    primaryColor: defaultColor,
    textTheme: TextTheme(
      subtitle1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: defaultColor,
        elevation: 40,
        type: BottomNavigationBarType.fixed),
  );
}

class AppThemeDark {
  static ThemeData appthemedark = ThemeData(
    
    textTheme: TextTheme(
      caption: TextStyle(color: Colors.white),
      subtitle1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor('333739'),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepOrange,
        elevation: 80,
        type: BottomNavigationBarType.fixed),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: HexColor('333739'),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),
    scaffoldBackgroundColor: HexColor('333739'),
  );
}
