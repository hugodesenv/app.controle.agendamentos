/// Made by Hugo Souza - 23/11/2023

import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';

class MyFieldText extends StatefulWidget {
  late String _title;
  late String _initialValue;
  late int _decimalSize;
  late IconData? _iconData;
  late Function(dynamic value)? _onChange;

  MyFieldText({
    super.key,
    String? title,
    String? initialValue,
    int? decimalSize,
    IconData? iconData,
    Function(dynamic value)? onChange,
  }) {
    _title = title ?? '';
    _initialValue = initialValue ?? '';
    _decimalSize = decimalSize ?? 0;
    _onChange = onChange;
    _iconData = iconData;
  }

  @override
  State<MyFieldText> createState() => _MyFieldTextState();
}

class _MyFieldTextState extends State<MyFieldText> {
  late TextEditingController controller;
  int oldLength = 0;

  @override
  void initState() {
    controller = TextEditingController();
    setControllerText = double.tryParse(widget._initialValue) ?? 0;
    super.initState();
  }

  set setControllerText(double value) {
    controller.text = value.toStringAsFixed(widget._decimalSize);
    oldLength = controller.text.length;
  }

  void setCursorPointerToTheEnd() {
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }

  void onKeyDown(RawKeyEvent value) {
    String keyLabel = value.data.logicalKey.keyLabel;

    if (keyLabel == 'Backspace') {
      setCursorPointerToTheEnd();
    }
  }

  void onChange(value) {
    widget._decimalSize > 0 ? handleNumberWithDecimal(value) : null;
    widget._onChange != null ? widget._onChange!(controller.text) : null;
  }

  void handleNumberWithDecimal(value) {
    double conversion = (double.tryParse(value) ?? 0);
    print('res: ${value.length}');
    print("*** old: ${oldLength}");

    if (controller.selection.end == controller.text.length) {
      if (value.length == 1) {
        conversion = conversion / 100.0;
      } else if (value.length < oldLength) {
        conversion = conversion / 10.0;
      } else {
        conversion = conversion * 10.0;
      }
    }

    setControllerText = conversion;
    setCursorPointerToTheEnd();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextTitle(title: widget._title),
        _inputValue(),
      ],
    );
  }

  Widget _inputValue() {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (value) => onKeyDown(value),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (value) => onChange(value),
        decoration: InputDecoration(
          suffix: Icon(
            widget._iconData,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
