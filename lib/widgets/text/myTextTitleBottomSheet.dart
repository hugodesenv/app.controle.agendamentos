import 'package:agendamentos/assets/colorConstantes.dart';
import 'package:flutter/material.dart';

class MyTextTitleBottomSheet extends StatelessWidget {
  final String _title;

  const MyTextTitleBottomSheet({Key? key, required String title})
      : _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color(primaryColor),
      ),
    );
  }
}
