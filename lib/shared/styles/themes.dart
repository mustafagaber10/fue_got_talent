
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: HexColor('1D1E20'),
  // canvasColor: HexColor('333739'),
  appBarTheme: const AppBarTheme(
    // color: Colors.deepPurpleAccent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.deepPurpleAccent,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.deepPurpleAccent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white70,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(size: 29.0, color: Colors.white70),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme:const IconThemeData(size: 27.0),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    //1D1E20
    //backgroundColor: HexColor('333739'),
    backgroundColor: HexColor('1D1E20'),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepPurpleAccent,
    unselectedItemColor: Colors.white70,
    elevation: 30.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.white70,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme = ThemeData(


  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(

    // color: Colors.deepPurple,
    systemOverlayStyle: SystemUiOverlayStyle(

      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    // backgroundColor: HexColor('4B0082'),
    // backgroundColor: Colors.deepPurple,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(size: 29.0, color: Colors.white),
    foregroundColor: Colors.transparent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(

    // enableFeedback: true,
    enableFeedback: false,
    type: BottomNavigationBarType.fixed,
    selectedIconTheme:const IconThemeData(size: 27.0),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.deepPurple[200],
    elevation: 20.0,
    backgroundColor: Colors.white,

  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),

  ),
);
