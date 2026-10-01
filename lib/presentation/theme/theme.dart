import 'package:flutter/material.dart';

const Color startPointColor = Color(0xFF64ffda);
const Color endPointColor = Color(0xFF009688);
const Color mainPointColor = Color(0xFF4CAF50);
const Color lockedPointColor = Color(0xFF000000);

final lightTheme = ThemeData(
  useMaterial3: true,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: Size.fromHeight(48),
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.black,
      disabledForegroundColor: Colors.black.withAlpha(120),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: const Color.fromARGB(255, 14, 79, 177)),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
);
