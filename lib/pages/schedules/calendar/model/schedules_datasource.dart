import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../models/schedule.dart';
import 'schedules_model.dart';

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<ScheduleModule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getSchedulesData(index).schedule.scheduleDate;
  }

  @override
  DateTime getEndTime(int index) {
    Schedule schedule = _getSchedulesData(index).schedule;
    var endDate = schedule.scheduleDate.add(Duration(minutes: schedule.totalMinutes));
    return endDate;
  }

  @override
  String getSubject(int index) {
    return _getSchedulesData(index).eventName;
  }

  @override
  Color getColor(int index) {
    String situation = _getSchedulesData(index).schedule.situation;
    if (situation == 'confirmed') {
      return Colors.green;
    } else if (situation == 'progress') {
      return Colors.amber;
    } else if (situation == 'canceled') {
      return Colors.redAccent;
    } else if (situation == 'completed') {
      return Colors.lightBlueAccent;
    } else {
      return Colors.grey;
    }
  }

  ScheduleModule _getSchedulesData(int index) {
    final dynamic meeting = appointments![index];
    late final ScheduleModule meetingData;
    if (meeting is ScheduleModule) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
