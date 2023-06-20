import 'package:flutter/material.dart';
import 'package:project_reunite/constants/appcolor.dart';

class AppData {
  static ThemeData theme = ThemeData().copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: Appcolor.backgrondColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Appcolor.backgrondColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Appcolor.darkAppColor,
      ));
}
