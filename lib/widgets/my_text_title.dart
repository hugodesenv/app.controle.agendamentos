import 'package:flutter/material.dart';

class MyTextTitle extends StatelessWidget {
  late String _title;

  MyTextTitle({Key? key, required String title}) : super(key: key) {
    _title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        _title,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
