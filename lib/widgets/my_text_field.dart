import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  late String _title;
  TextAlign? _titleAlign;
  Icon? _suffixIcon;

  MyTextField({
    Key? key,
    required String title,
    TextAlign? titleAlign,
    Icon? suffixIcon,
  }) : super(key: key) {
    _title = title;
    _titleAlign = titleAlign;
    _suffixIcon = suffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextTitle(title: _title, align: _titleAlign),
        TextField(
          decoration: InputDecoration(
            suffixIcon: _suffixIcon,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
