import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  late String _title;
  dynamic? _initialValue;
  TextAlign? _titleAlign;
  Icon? _suffixIcon;
  late Function(dynamic value)? _onChange;

  MyTextField({
    Key? key,
    required String title,
    TextAlign? titleAlign,
    Icon? suffixIcon,
    dynamic initialValue,
    required Function(dynamic value)? onChange,
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
  late TextEditingController tecValue;

  @override
  void initState() {
    tecValue = TextEditingController(text: widget._initialValue);
    tecValue.addListener(() {
      if (widget._onChange != null) {
        widget._onChange!(tecValue.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    tecValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextTitle(title: widget._title, align: widget._titleAlign),
        TextField(
          controller: tecValue,
          decoration: InputDecoration(
            suffixIcon: widget._suffixIcon,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
