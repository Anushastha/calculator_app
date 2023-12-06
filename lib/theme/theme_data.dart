import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: 'Montserrat Bold',
    scaffoldBackgroundColor: Colors.deepPurple.shade100,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
    ),
  );
}
