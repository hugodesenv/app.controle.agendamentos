import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateField extends StatefulWidget {
  final String _title;
  final DateTime? _initialValue;
  final Function(DateTime? selectedDate) _onChanged;

  const MyDateField({
    Key? key,
    required String title,
    required Function(DateTime? selectedDate) onChanged,
    required DateTime? initialValue,
  })  : _title = title,
        _onChanged = onChanged,
        _initialValue = initialValue,
        super(key: key);

  @override
  State<MyDateField> createState() => _MyDateFieldState();
}

class _MyDateFieldState extends State<MyDateField> {
  final _tecValue = TextEditingController();

  @override
  void dispose() {
    _tecValue.dispose();
    super.dispose();
  }

  set textValue(DateTime? selectedDate) {
    if (selectedDate != null) {
      String formatDate = DateFormat("dd/MM/yyyy").format(selectedDate);
      String formatTime = DateFormat("HH:mm").format(selectedDate);

      _tecValue.text = "$formatDate às $formatTime";
    }
  }

  @override
  void initState() {
    super.initState();
    textValue = widget._initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextTitle(title: widget._title),
        TextField(
          controller: _tecValue,
          readOnly: true,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.date_range_outlined),
          ),
          onTap: () async => await callDateTimePicker(context),
        ),
      ],
    );
  }

  Future<void> callDateTimePicker(BuildContext context) async {
    DateTime? selectedDate = await _showDateTimePicket(context);
    textValue = selectedDate;
    widget._onChanged(selectedDate);
  }

  Future<DateTime?> _showDateTimePicket(context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1899),
      lastDate: DateTime(2999),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        Duration duration = Duration(hours: time.hour, minutes: time.minute);
        date = date.add(duration);
      }
    }
    return date;
  }
}
