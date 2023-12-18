import 'package:flutter/material.dart';

class SkedolTextField extends StatelessWidget {
  String titulo = '';
  late bool _autoFocus;
  late IconData icone;
  late Function(String? valor) onChange;

  SkedolTextField({
    required this.titulo,
    required this.icone,
    required this.onChange,
    bool? autoFocus,
    super.key,
  }) {
    _autoFocus = autoFocus ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        TextFormField(
          autofocus: _autoFocus,
          decoration: InputDecoration(
            suffixIcon: Icon(
              icone,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onChanged: onChange,
        ),
      ],
    );
  }
}
