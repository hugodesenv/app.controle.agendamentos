/// Made by Hugo Souza - 23/11/2023

import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';

class MyNumericField extends StatefulWidget {
  final String title;
  final String initialValue;
  final int decimalSize;
  final IconData? iconData;
  final Function(dynamic value) onChange;

  const MyNumericField({
    Key? key,
    required this.initialValue,
    required this.onChange,
    this.decimalSize = 0,
    this.iconData,
    this.title = '',
  }) : super(key: key);

  @override
  State<MyNumericField> createState() => _MyNumericFieldState();
}

class _MyNumericFieldState extends State<MyNumericField> {
  late TextEditingController controller;
  int oldLength = 0;

  bool get isDecimalNumber => widget.decimalSize > 0;

  bool get isPointerAtTheEnd =>
      controller.selection.end == controller.text.length;

  @override
  void initState() {
    controller = TextEditingController();
    textToDouble();
    super.initState();
  }

  void textToDouble() {
    setText = double.tryParse(widget.initialValue) ?? 0;
  }

  set setText(double value) {
    controller.text = value.toStringAsFixed(widget.decimalSize);

    oldLength = controller.text.length;
    handleCursor();
  }

  void handleCursor() {
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  void onKeyDown(RawKeyEvent value) {
    String keyLabel = value.data.logicalKey.keyLabel;

    if (keyLabel == 'Backspace') {
      handleCursor();
    }
  }

  void settupNumber(value) {
    double conversion = (double.tryParse(value) ?? 0);

    if ((isDecimalNumber) && (isPointerAtTheEnd)) {
      if (value.length < oldLength) {
        conversion = conversion / 10.0;
      } else {
        conversion = conversion * 10.0;
      }
    }

    setText = conversion;
  }

  @override
  void didUpdateWidget(covariant MyNumericField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      textToDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextTitle(title: widget.title),
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
        onChanged: (value) {
          settupNumber(value);
          widget.onChange(controller.text);
        },
        decoration: InputDecoration(
          suffix: Icon(
            widget.iconData,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
