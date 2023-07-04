import 'package:agendamentos/assets/colorConstantes.dart';
import 'package:flutter/material.dart';

const zeroDuration = Duration.zero;

/// return the default style modal bottom sheet
const shapeModalBottomSheet = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(18.0),
  ),
);

/// returns the style of bottom sheet titles
TextStyle textStyleTitleModalBottomSheet(BuildContext context) {
  return TextStyle(
    color: primaryColor(context),
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );
}

void mySnackbar(BuildContext context, String message, {Color? background, int? secondsDuration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: background,
      duration: Duration(seconds: secondsDuration ?? 2),
    ),
  );
}
