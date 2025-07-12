import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
final appTheme = ThemeData(
  splashColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  colorScheme: const ColorScheme.light(
    primaryContainer: Color(0xFFF3F6FC),
    secondaryContainer: Color(0xFF7B5CF7),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 20),
    titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 17),
    displaySmall: TextStyle(fontSize: 11, color: Colors.black38),
  ),
  fontFamily: GoogleFonts.tajawal().toString(),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(6)),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red.withOpacity(0.3)),borderRadius: BorderRadius.circular(6)),
    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF7B5CF7)),borderRadius: BorderRadius.circular(6)),
    focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(6)),
    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),borderRadius: BorderRadius.circular(6)),
    labelStyle: const TextStyle(fontSize: 14),
    floatingLabelStyle: const TextStyle(color: Colors.lightBlue),
    prefixStyle: const TextStyle(fontSize: 15, color: Colors.blue),
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.grey.withOpacity(0.2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: const WidgetStatePropertyAll(Color(0xFF2D2E2F)),
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
    )
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.lightBlue.withOpacity(0.1),
    backgroundColor: Colors.white,
    elevation: 0.2,
    height: 70,
    iconTheme: const WidgetStatePropertyAll(IconThemeData(color: Colors.black))
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    backgroundColor: Colors.blue,
    elevation: 0,
  ),
);
