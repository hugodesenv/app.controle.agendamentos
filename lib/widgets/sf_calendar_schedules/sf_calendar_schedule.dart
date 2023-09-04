/**
 * O que falta fazer?
 * -> Trocar as cores conforme as situações
 * Tratar os horarios, questoes de UTC
 */

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../repository/api/schedule_repository.dart';
import 'model/schedules_datasource.dart';
import 'model/schedules_model.dart';

class SfCalendarSchedule extends StatefulWidget {
  BuildContext context;
  bool refresh;

  SfCalendarSchedule({
    Key? key,
    required this.context,
    required this.refresh,
  }) : super(key: key);

  @override
  State<SfCalendarSchedule> createState() => _SfCalendarScheduleState();
}

class _SfCalendarScheduleState extends State<SfCalendarSchedule> {
  List<ScheduleModule> _schedules = [];

  void _refreshData() async {
    var repository = ScheduleRepository.instance;
    var scheduleResult = await repository.findAll() as List<ScheduleModule>;
    setState(() {
      _schedules = scheduleResult;
    });
  }

  @override
  void didUpdateWidget(covariant SfCalendarSchedule oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.refresh == true) {
      print("** sf_calendar_schedule -> refreshing data");
      widget.refresh = false;
      _refreshData();
    }
  }

  @override
  Widget build(_) {
    return SfCalendar(
      dataSource: ScheduleDataSource(_schedules),
      todayHighlightColor: Theme
          .of(widget.context)
          .primaryColor,
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
  }
}
