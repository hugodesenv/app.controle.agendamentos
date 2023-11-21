import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'bloc/schedules_bloc.dart';
import 'model/schedules_datasource.dart';
import 'model/schedules_model.dart';

class ScheduleCalendar extends StatelessWidget {
  late Function(DateTime? date, Map values) _onTotals;
  late Function(ScheduleModule scheduleModule) _onScheduleClick;
  late Function(DateTime date) _onEmptyClick;
  late List<ScheduleModule> _schedules;

  ScheduleCalendar({
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
      dataSource: ScheduleDataSource(_schedules),
      todayHighlightColor: Theme.of(context).primaryColor,
      showDatePickerButton: true,
      onTap: (calendarTapDetails) async =>
          await _openDetails(context, calendarTapDetails),
      onSelectionChanged: (calendarSelectionDetails) =>
          _onResultValues(calendarSelectionDetails.date, {}),
      onViewChanged: (viewChangedDetails) =>
          _onResultValues(viewChangedDetails.visibleDates[0], {}),
      allowedViews: const [
        CalendarView.day,
        CalendarView.month,
        CalendarView.schedule,
        CalendarView.week,
        CalendarView.workWeek,
      ],
    );
  }

  _openDetails(BuildContext context, CalendarTapDetails details) async {
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

  _onResultValues(DateTime? date, Map totals) {
    String key = DateFormat.yMMMMd().format(date!);
    totals[key] != null ? _onTotals(date, totals[key]) : _onTotals(date, {});
  }
}
