import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var colorList = <Color>[
  Color(0xFF1A237E),
  Color.fromARGB(255, 14, 137, 141),
  Colors.teal,
  Colors.green,
  const Color(0xFFB81414),
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0, 'Selected color must be greater then 0'),
        assert(selectedColor < colorList.length,
            'Selected color must be less or equal than ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(

      ///* General
      useMaterial3: true,
      colorSchemeSeed: colorList[selectedColor],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorList[selectedColor],
          foregroundColor: Colors.white,
          extendedTextStyle:
              const TextStyle(color: Colors.white, fontSize: 15)),
      buttonTheme: ButtonThemeData(
          buttonColor: colorList[selectedColor],
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(colorList[selectedColor]),
              foregroundColor: MaterialStateProperty.all(Colors.white))),

      ///* Texts
      textTheme: TextTheme(
          titleLarge: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          titleSmall:
              GoogleFonts.montserratAlternates().copyWith(fontSize: 20)),

      ///* Scaffold Background Color
      scaffoldBackgroundColor: colorList[selectedColor],

      ///* AppBar
      appBarTheme: AppBarTheme(
        color: colorList[selectedColor],
        titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ));
}
