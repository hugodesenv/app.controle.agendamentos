import 'package:agendamentos/enum/agendamento_situacao_enum.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../../models/schedule.dart';
import 'schedules_model.dart';

class AgendaDataSource extends CalendarDataSource {
  AgendaDataSource(List<ScheduleModule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _obterDadosAgendamento(index).schedule.scheduleDate;
  }

  @override
  DateTime getEndTime(int index) {
    var compromisso = _obterDadosAgendamento(index).schedule;
    var ultimoDia = compromisso.scheduleDate.add(
      Duration(minutes: compromisso.totalMinutes),
    );
    return ultimoDia;
  }

  @override
  String getSubject(int index) {
    return _obterDadosAgendamento(index).eventName;
  }

  @override
  Color getColor(int index) {
    var situacao = _obterDadosAgendamento(index).schedule.situation.text();
    var map = Schedule.fromText(situacao);
    return map[ScheduleFromText.tColor];
  }

  ScheduleModule _obterDadosAgendamento(int index) {
    final dynamic meeting = appointments![index];
    late final ScheduleModule meetingData;
    if (meeting is ScheduleModule) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
