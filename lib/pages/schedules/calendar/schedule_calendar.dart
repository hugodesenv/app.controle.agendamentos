import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'bloc/schedules_bloc.dart';
import 'bloc/schedules_state.dart';
import 'model/schedules_datasource.dart';
import 'model/schedules_model.dart';

class ScheduleCalendar extends StatelessWidget {
  late SchedulesBloc _bloc;
  late Function(DateTime? date, Map values) _onTotals;
  late Function(ScheduleModule scheduleModule) _onScheduleClick;
  late Function(DateTime date) _onEmptyClick;

  ScheduleCalendar({
    Key? key,
    required SchedulesBloc bloc,
    required Function(DateTime? date, Map values) onTotals,
    required Function(ScheduleModule scheduleModule) onScheduleClick,
    required Function(DateTime date) onEmptyClick,
  }) : super(key: key) {
    _bloc = bloc;
    _onTotals = onTotals;
    _onScheduleClick = onScheduleClick;
    _onEmptyClick = onEmptyClick;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (_, SchedulesState state) {
        return SfCalendar(
          dataSource: ScheduleDataSource(state.schedules),
          todayHighlightColor: Theme.of(context).primaryColor,
          showDatePickerButton: true,
          onTap: (calendarTapDetails) async => await _openDetails(context, calendarTapDetails),
          onSelectionChanged: (calendarSelectionDetails) => _onResultValues(calendarSelectionDetails.date, state.totals),
          onViewChanged: (viewChangedDetails) => _onResultValues(viewChangedDetails.visibleDates[0], state.totals),
          allowedViews: const [
            CalendarView.day,
            CalendarView.month,
            CalendarView.schedule,
            CalendarView.week,
            CalendarView.workWeek,
          ],
        );
      },
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
