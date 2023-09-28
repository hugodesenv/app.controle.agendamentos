import 'package:flutter/material.dart';

class MyTextTitle extends StatelessWidget {
  late String _title;
  TextAlign? _align;

  MyTextTitle({Key? key, required String title, TextAlign? align}) : super(key: key) {
    _title = title;
    _align = align;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        _title,
        textAlign: _align,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
