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
        // Define global theme of app
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: FONTCOLOR,
        ),
        // Theme for bottom naviggator component
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 10.0,
          backgroundColor: Colors.white,
          selectedItemColor: PRIMARYCOLOR,
          unselectedItemColor: Colors.grey,
        ),
        // Set differents TextStyle for multiple type of text
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: FONTCOLOR, fontSize: 30.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 14.0),
          bodyText2: TextStyle(color: PRIMARYCOLOR, fontSize: 14.0),
        ),
        // Theme to apply border radius white color to all input of app
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(BORDERRADIUS),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
        ),
        // Theme to apply border radius to all dialog of app
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BORDERRADIUS),
          ),
        ),
      );
}
