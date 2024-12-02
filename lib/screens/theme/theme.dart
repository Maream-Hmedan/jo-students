import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(238, 238, 250, 1),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Color(0xff96959d)),
    bodySmall: TextStyle(color: Color(0xffe6e6e8)),
   displayLarge: TextStyle(color: Color(0xff444050)),
    displaySmall: TextStyle(color:Colors.black54),
    displayMedium: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),
    titleLarge: TextStyle(color: Color(0xff444050)),
    titleMedium: TextStyle(color:Color(0xffacaab1)),
    titleSmall: TextStyle(color:  Color(0xfff3f2f3),),
    headlineSmall: TextStyle(color:  Color(0xff6d6b77),),
    headlineMedium: TextStyle(color:   Color(0xff8D8A94),),
    labelSmall:TextStyle(color:   Color(0xff25293c),),
    labelMedium: TextStyle(color:   Color(0xffebf5eb),),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff2d324a),
  ),
  scaffoldBackgroundColor: const Color(0xff25293c),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xffcfcde4)),
    bodyMedium: TextStyle(color: Color(0xffa3a2b8)),
    bodySmall: TextStyle(color: Color(0xff44485e)),
    displayLarge: TextStyle(color: Color(0xffa3a2b8)),
    displaySmall: TextStyle(color: Color(0xffa3a2b8)),
    displayMedium: TextStyle(color:Color(0xff25293c)),
    titleLarge: TextStyle(color: Color(0xffcfcde4)),
    titleMedium: TextStyle(color: Color(0xff76778e)),
    titleSmall: TextStyle(color: Color(0xff3a3d53)),
    headlineSmall: TextStyle(color:  Color(0xffACABC1),),
    headlineMedium: TextStyle(color:   Color(0xff9191A8),),
    labelSmall: TextStyle(color:Color.fromARGB(255, 255, 255, 255),),
    labelMedium: TextStyle(color:   Color(0xff2b3943),),
  ),
);
