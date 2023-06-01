import 'package:agendamentos/assets/colorConstantes.dart';
import 'package:flutter/material.dart';

class MySearchTextField extends StatelessWidget {
  final Function(String value) _onChanged;

  const MySearchTextField({Key? key, required Function(String value) onChanged})
      : _onChanged = onChanged,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.search),
        labelText: 'Filtrar...',
        labelStyle: TextStyle(color: Color(primaryColor)),
      ),
      style: const TextStyle(color: Color(primaryColor)),
      cursorColor: const Color(primaryColor),
      onChanged: _onChanged,
    );
  }
}
