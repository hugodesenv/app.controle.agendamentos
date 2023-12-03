import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'model/agenda_datasource.dart';
import 'model/schedules_model.dart';

// ignore: must_be_immutable
class AgendaCalendario extends StatelessWidget {
  late Function(DateTime? date, Map values) _onTotals;
  late Function(ScheduleModule scheduleModule) _onScheduleClick;
  late Function(DateTime date) _onEmptyClick;
  late List<ScheduleModule> _schedules;

  AgendaCalendario({
    Key? key,
    required Function(DateTime? date, Map values) onTotals,
    required Function(ScheduleModule scheduleModule) onScheduleClick,
    required Function(DateTime date) onEmptyClick,
    required List<ScheduleModule> schedules,
  }) : super(key: key) {
    _schedules = schedules;
    _onTotals = onTotals;
    _onScheduleClick = onScheduleClick;
    _onEmptyClick = onEmptyClick;
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      dataSource: AgendaDataSource(_schedules),
      todayHighlightColor: Theme.of(context).primaryColor,
      showDatePickerButton: true,
      onTap: (calendarTapDetails) async =>
          await abrirDetalhe(context, calendarTapDetails),
      onSelectionChanged: (calendarSelectionDetails) =>
          resultarValores(calendarSelectionDetails.date, {}),
      onViewChanged: (viewChangedDetails) =>
          resultarValores(viewChangedDetails.visibleDates[0], {}),
      allowedViews: const [
        CalendarView.day,
        CalendarView.month,
        CalendarView.schedule,
        CalendarView.week,
        CalendarView.workWeek,
      ],
    );
  }

  abrirDetalhe(BuildContext context, CalendarTapDetails details) async {
    switch (details.targetElement) {
      case CalendarElement.appointment:
      case CalendarElement.agenda:
        {
          ScheduleModule scheduleModule = details.appointments![0];
          _onScheduleClick(scheduleModule);
        }
        break;
      case CalendarElement.calendarCell:
        {
          int length = details.appointments?.length ?? 0;
          if (length == 0) {
            _onEmptyClick(details.date ?? DateTime.timestamp());
          }
        }
        break;
    }
  }

  resultarValores(DateTime? date, Map totals) {
    String key = DateFormat.yMMMMd().format(date!);
    totals[key] != null ? _onTotals(date, totals[key]) : _onTotals(date, {});
  }
}
