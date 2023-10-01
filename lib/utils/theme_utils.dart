import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkedolTheme {
  static const _primaryWhiteColor = Color(0xFF2abf84);
  static const _primaryDarkColor = Colors.pink;

  get primaryWhiteColor => _primaryWhiteColor;

  get primaryDarkColor => _primaryDarkColor;

  Color? getWhiteScaffoldBackgroundColor() {
    return Colors.white;
  }

  FloatingActionButtonThemeData? getWhiteFloatingActionButtonThemeData() {
    return const FloatingActionButtonThemeData(
      backgroundColor: _primaryWhiteColor,
      splashColor: _primaryDarkColor,
      foregroundColor: Colors.white,
      hoverColor: Colors.white,
    );
  }

  DividerThemeData? getWhiteDividerThemeData() {
    return DividerThemeData(
      color: Colors.grey[200],
    );
  }

  InputDecorationTheme? getWhiteInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF6F3F3),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(width: 4, color: _primaryWhiteColor),
        borderRadius: BorderRadius.circular(12),
      ),
      suffixIconColor: Colors.black12,
    );
  }

  TabBarTheme getWhiteTabBarTheme() {
    return const TabBarTheme(
      labelColor: _primaryWhiteColor,
      unselectedLabelColor: Colors.black26,
      labelPadding: EdgeInsets.all(16),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.black12,
        ),
      ),
    );
  }

  ListTileThemeData getWhiteListTileTheme() {
    return const ListTileThemeData(
      iconColor: Colors.black45,
      titleTextStyle: TextStyle(fontSize: 14.0, color: Colors.black54),
    );
  }

  AppBarTheme getWhiteAppBarTheme() {
    return AppBarTheme(
      color: Colors.white,
      elevation: 1,
      titleTextStyle: GoogleFonts.poppins(color: Colors.black45, fontWeight: FontWeight.w600),
      iconTheme: const IconThemeData(color: Colors.black54),
    );
  }

  SnackBarThemeData getWhiteSnackBarThemeData() {
    return SnackBarThemeData(
      backgroundColor: primaryWhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    );
  }

  DatePickerThemeData getWhiteDatePickerTheme() {
    return const DatePickerThemeData(
      headerForegroundColor: _primaryWhiteColor,
    );
  }

  IconThemeData getWhiteIconTheme() {
    return IconThemeData(color: primaryWhiteColor);
  }

  ProgressIndicatorThemeData getWhiteProgressIndicatorTheme() {
    return ProgressIndicatorThemeData(
      color: primaryDarkColor,
      circularTrackColor: primaryWhiteColor,
    );
  }

  TextButtonThemeData getWhiteTextButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  DialogTheme getWhiteDialogTheme() {
    return DialogTheme(
      elevation: 8,
      titleTextStyle: const TextStyle(
        fontSize: 14,
        color: _primaryWhiteColor,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: const TextStyle(fontSize: 14, color: _primaryWhiteColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: primaryWhiteColor,
    );
  }

  ElevatedButtonThemeData getWhiteElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryWhiteColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
