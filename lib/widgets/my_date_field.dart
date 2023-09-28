import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateField extends StatefulWidget {
  late final String _title;
  late final Function(DateTime? selectedDate) _onChanged;

  MyDateField({Key? key, required String title, required Function(DateTime? selectedDate) onChanged})
      : _title = title,
        _onChanged = onChanged,
        super(key: key);

  @override
  State<MyDateField> createState() => _MyDateFieldState();
}

class _MyDateFieldState extends State<MyDateField> {
  var tecValue = TextEditingController();

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
        MyTextTitle(title: widget._title),
        TextField(
          controller: tecValue,
          readOnly: true,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.date_range_outlined),
          ),
          onTap: () async {
            await callDateTimePicker(context);
          },
        ),
      ],
    );
  }

  Future<void> callDateTimePicker(BuildContext context) async {
    DateTime? selected_date = await _showDateTimePicket(context);

    if (selected_date != null) {
      String formatDate = DateFormat("dd/MM/yyyy").format(selected_date!);
      String formatTime = DateFormat("HH:mm").format(selected_date!);

      tecValue.text = "$formatDate às $formatTime";
    }

    widget._onChanged(selected_date);
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
