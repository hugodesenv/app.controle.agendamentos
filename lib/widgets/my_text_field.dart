import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  late String _title;
  dynamic _initialValue;
  TextAlign? _titleAlign;
  Icon? _suffixIcon;
  late Function(dynamic value)? _onChange;

  MyTextField({
    Key? key,
    required String title,
    required Function(dynamic value)? onChange,
    dynamic initialValue,
    TextAlign? titleAlign,
    Icon? suffixIcon,
  }) : super(key: key) {
    _title = title;
    _titleAlign = titleAlign;
    _suffixIcon = suffixIcon;
    _initialValue = initialValue;
    _onChange = onChange;
  }

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controllerField;

  @override
  void initState() {
    super.initState();
    _controllerField = TextEditingController(text: widget._initialValue);
  }

  @override
  void didUpdateWidget(covariant MyTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._initialValue != oldWidget._initialValue) {
      _controllerField.text = widget._initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextTitle(
          title: widget._title,
          align: widget._titleAlign,
        ),
        TextFormField(
          controller: _controllerField,
          onChanged: (value) => _onChange(value),
          decoration: InputDecoration(
            suffixIcon: widget._suffixIcon,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  void _onChange(dynamic value) {
    if (widget._onChange != null) {
      widget._onChange!(value);
    }
  }
}
