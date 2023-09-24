import 'package:flutter/material.dart';

class MySearchTextField extends StatelessWidget {
  final Function(String value) _onChanged;
  final String? _labelText;

  const MySearchTextField({Key? key, required Function(String value) onChanged, String? labelText})
      : _onChanged = onChanged,
        _labelText = labelText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search),
        labelText: _labelText ?? 'Filtrar...',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),
      style: TextStyle(color: Theme.of(context).primaryColor),
      cursorColor: Theme.of(context).primaryColor,
      onChanged: _onChanged,
    );
  }
}
