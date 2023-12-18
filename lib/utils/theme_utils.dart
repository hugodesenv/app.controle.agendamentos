import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkedolTheme {
  static const _primaryWhiteColor = Color.fromARGB(255, 0, 51, 255);
  static const _primaryDarkColor = Color.fromARGB(255, 0, 191, 255);

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
      titleTextStyle: TextStyle(color: Colors.black87),
    );
  }

  AppBarTheme getWhiteAppBarTheme() {
    return AppBarTheme(
      elevation: 2,
      titleTextStyle: GoogleFonts.inter(
        color: Colors.black45,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
      iconTheme: const IconThemeData(color: Colors.black45),
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
        color: _primaryWhiteColor,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: const TextStyle(color: _primaryWhiteColor),
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
