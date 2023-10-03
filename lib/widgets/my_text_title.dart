import 'package:flutter/material.dart';

class MyTextTitle extends StatelessWidget {
  late String _title;
  TextAlign? _align;
  double? _fontSize;

  MyTextTitle({Key? key, required String title, TextAlign? align, double? fontSize}) : super(key: key) {
    _title = title;
    _align = align;
    _fontSize = fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        _title,
        textAlign: _align,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: _fontSize,
        ),
      ),
    );
  }
}
