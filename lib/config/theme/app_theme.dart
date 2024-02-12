import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var colorList = <Color>[
  const Color.fromARGB(255, 14, 137, 141),
  const Color(0xFF1A237E),
  Colors.green,
  const Color(0xFFB81414),
  Colors.deepPurple,
  Colors.orange,
  Colors.pinkAccent,
];

var nameList = <String>[
  "Verde Leaf",
  "Azul",
  "Verde Claro",
  "Rojo",
  "Morado",
  "Anaranjado",
  "Rosa"
];

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;
  final Color? scaffoldBackgroundColor;
  final InputDecorationTheme? inputDecorationTheme;

  AppTheme(
      {this.selectedColor = 0,
      this.scaffoldBackgroundColor,
      this.inputDecorationTheme,
      this.isDarkmode = false})
      : assert(selectedColor >= 0, 'Selected color must be greater then 0'),
        assert(selectedColor < colorList.length,
            'Selected color must be less or equal than ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(

      ///* General
      useMaterial3: true,
      colorSchemeSeed: colorList[selectedColor],
      brightness: isDarkmode ? Brightness.dark : Brightness.light,
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
        titleSmall: GoogleFonts.montserratAlternates().copyWith(fontSize: 20),
      ),

      ///* Scaffold Background Color
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? colorList[selectedColor],

      ///* Buttons
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                  GoogleFonts.montserratAlternates()
                      .copyWith(fontWeight: FontWeight.w700)))),
      inputDecorationTheme: inputDecorationTheme,

      ///* AppBar
      appBarTheme: AppBarTheme(
        color: colorList[selectedColor],
        titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ));

  AppTheme copyWith(
          {int? selectedColor,
          bool? isDarkmode,
          Color? scaffoldBackgroundColor,
          InputDecorationTheme? inputDecorationTheme}) =>
      AppTheme(
          selectedColor: selectedColor ?? this.selectedColor,
          isDarkmode: isDarkmode ?? this.isDarkmode,
          scaffoldBackgroundColor:
              scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
          inputDecorationTheme:
              inputDecorationTheme ?? this.inputDecorationTheme);
}
