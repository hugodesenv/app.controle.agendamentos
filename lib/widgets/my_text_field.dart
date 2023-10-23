import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  late String _title;
  late Function(dynamic value)? _onChange;
  dynamic _initialValue;
  TextAlign? _titleAlign;
  Icon? _suffixIcon;
  TextInputType? _textInputType;
  List<TextInputFormatter>? _inputFormatters;

  MyTextField({
    Key? key,
    required String title,
    required Function(dynamic value)? onChange,
    dynamic initialValue,
    TextAlign? titleAlign,
    Icon? suffixIcon,
    TextInputType? textInputType,
    List<TextInputFormatter>? inputFormatters,
  }) : super(key: key) {
    _title = title;
    _titleAlign = titleAlign;
    _suffixIcon = suffixIcon;
    _initialValue = initialValue;
    _onChange = onChange;
    _textInputType = textInputType;
    _inputFormatters = inputFormatters;
  }

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controllerField;

  @override
  void initState() {
    _settupControllerField();
    super.initState();
  }

  @override
  void dispose() {
    _controllerField.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MyTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._initialValue != oldWidget._initialValue) {
      print("** valor aqui");
      var currentPosSelection = _controllerField.selection;
      _controllerField.text = widget._initialValue;
      _controllerField.selection = currentPosSelection;
    }
  }

  void _settupControllerField() {
    _controllerField = TextEditingController(text: widget._initialValue);
    _controllerField.addListener(() {
      if (widget._onChange != null) {
        widget._onChange!(_controllerField.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextTitle(title: widget._title, align: widget._titleAlign),
        TextField(
          controller: _controllerField,
          decoration: InputDecoration(
            suffixIcon: widget._suffixIcon,
            fillColor: Colors.grey[200],
          ),
          inputFormatters: widget._inputFormatters,
          keyboardType: widget._textInputType,
        ),
      ],
    );
  }
}
