import 'package:flutter/material.dart';

class MyLoginTextField extends StatefulWidget {
  String _labelText = '';
  TextEditingController? _controller;
  bool _hideText = true;
  bool? _isPassword;
  bool _autoFocus = false;

  MyLoginTextField(
      {super.key,
      TextEditingController? controller,
      required labelText,
      bool? isPassword,
      bool? autoFocus}) {
    _labelText = labelText;
    _controller = controller;
    _isPassword = isPassword ?? false;
    _autoFocus = autoFocus ?? false;
  }

  @override
  State<MyLoginTextField> createState() => _MyLoginTextFieldState();
}

class _MyLoginTextFieldState extends State<MyLoginTextField> {
  Widget _suffixIcon(Color pMainColor) {
    IconData icon = widget._hideText ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    return GestureDetector(
      child: Icon(icon, color: widget._hideText ? pMainColor : Colors.orange),
      onTap: () async {
        setState(() {
          widget._hideText = !widget._hideText;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).primaryColor;

    return TextField(
      autofocus: widget._autoFocus,
      controller: widget._controller,
      obscureText: widget._hideText && widget._isPassword == true,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w500, fontSize: 15),
        labelText: widget._labelText,
        suffixIcon: widget._isPassword == true ? _suffixIcon(mainColor) : null,
        suffixIconColor: mainColor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.5),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).focusColor, width: 3),
            borderRadius: BorderRadius.circular(20)),
      ),
      cursorColor: mainColor,
      style: TextStyle(color: mainColor),
    );
  }
}
