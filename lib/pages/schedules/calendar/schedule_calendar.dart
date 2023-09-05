import 'package:agendamentos/pages/schedules/calendar/bloc/schedules_event.dart';
import 'package:agendamentos/pages/schedules/calendar/model/schedules_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'bloc/schedules_bloc.dart';
import 'bloc/schedules_state.dart';
import 'model/schedules_datasource.dart';

class ScheduleCalendar extends StatelessWidget {
  const ScheduleCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SchedulesBloc(SchedulesState())..add(SchedulesEventLoad()),
      child: Builder(
        builder: (BuildContext context) {
          var bloc = BlocProvider.of<SchedulesBloc>(context);
          return BlocBuilder(
            bloc: bloc,
            builder: (_, SchedulesState state) {
              return SfCalendar(
                dataSource: ScheduleDataSource(state.schedules),
                todayHighlightColor: Theme.of(context).primaryColor,
                onTap: (calendarTapDetails) => _openDetails(context, calendarTapDetails),
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.month,
                  CalendarView.schedule,
                  CalendarView.timelineDay,
                  CalendarView.timelineMonth,
                  CalendarView.timelineWeek,
                  CalendarView.timelineWorkWeek,
                  CalendarView.week,
                  CalendarView.workWeek,
                ],
              );
            },
          );
        },
      ),
    );
  }

  _openDetails(BuildContext context, CalendarTapDetails details) async {
    if (details.targetElement == CalendarElement.appointment || details.targetElement == CalendarElement.agenda) {
      ScheduleModule scheduleModule = details.appointments![0];

      await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(scheduleModule.schedule.customer.name),
                Text(scheduleModule.schedule.totalMinutes.toString()),
              ],
            ),
          );
        },
      );
    }
  }
}
