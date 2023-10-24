import 'package:flutter/material.dart';

class MyFieldNumber extends StatefulWidget {
  const MyFieldNumber({super.key});

  @override
  State<MyFieldNumber> createState() => _MyFieldNumberState();
}

class _MyFieldNumberState extends State<MyFieldNumber> {
  TextEditingController controller = TextEditingController();
  int oldLength = 0;

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

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (value) => onKeyDown(value),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          double conversion = (double.tryParse(value) ?? 0);

          if (controller.selection.end == controller.text.length) {
            if (value.length == 1) {
              conversion = conversion / 100.0;
            } else if (value.length < oldLength) {
              conversion = conversion / 10.0;
            } else {
              conversion = conversion * 10.0;
            }
          }

          controller.text = conversion.toStringAsFixed(2);
          setCursorPointerToTheEnd();

          oldLength = controller.text.length;
        },
      ),
    );
  }
}
