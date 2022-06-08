import 'package:brain_saver_flutter/views/theme/style_const.dart';
import 'package:flutter/material.dart';

// Definition of Theme Application
// Contains differents subthemes which represent each one theme for widgets (input, button, text, etc.)
class AppTheme {
  ThemeData get Theme => ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: PRIMARYCOLOR,
      scaffoldBackgroundColor: Colors.white,
      // Define the default font family.
      fontFamily: 'Montserrat',
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: FONTCOLOR,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 10.0,
        backgroundColor: Colors.white,
        selectedItemColor: PRIMARYCOLOR,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
            color: FONTCOLOR, fontSize: 30.0, fontWeight: FontWeight.bold),
        headline2: TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(
            color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(fontSize: 14.0),
        bodyText2: TextStyle(color: PRIMARYCOLOR, fontSize: 14.0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(BORDERRADIUS),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: PRIMARYCOLOR,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BORDERRADIUS),
          ),
          textStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Montserrat'),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDERRADIUS),
        ),
      ));
}
