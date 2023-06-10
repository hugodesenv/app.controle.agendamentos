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
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search),
        labelText: 'Filtrar...',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),
      style: TextStyle(color: Theme.of(context).primaryColor),
      cursorColor: Theme.of(context).primaryColor,
      onChanged: _onChanged,
    );
  }
}
