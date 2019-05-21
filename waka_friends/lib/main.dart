import 'package:flutter/material.dart';
import 'package:waka_friends/menu/menu.dart';

//TODO Initzialize firebase in swift code

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color.fromRGBO(35, 61, 77, 1.0),
        accentColor: Colors.white70,

        scaffoldBackgroundColor: Color.fromRGBO(254, 127, 45, 1.0),

        textTheme: TextTheme(
          display1: TextStyle(
            color: Colors.white,
            fontSize: 90.0,
            fontFamily: "CaptionFont",
          ),
          body1: TextStyle(
            color: Colors.white,
            fontFamily: "MainFont",
          ),
          button: TextStyle(
            fontSize: 18.0,
            fontFamily: "MainFont",
          ),
        ),

        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromRGBO(35, 61, 77, 1.0),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))
        ),

        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(40.0)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(40.0)),
        )
      ),

      home: Menu()
    );
  }
}
