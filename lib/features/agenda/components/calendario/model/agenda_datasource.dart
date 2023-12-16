import 'package:agendamentos/enum/agendamento_situacao_enum.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../models/schedule.dart';

class AgendaDataSource extends CalendarDataSource {
  AgendaDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _obterDadosAgendamento(index).scheduleDate;
  }

  @override
  DateTime getEndTime(int index) {
    var compromisso = _obterDadosAgendamento(index);
    var ultimoDia = compromisso.scheduleDate.add(
      Duration(minutes: compromisso.totalMinutes),
    );
    return ultimoDia;
  }

  @override
  String getSubject(int index) {
    return _obterDadosAgendamento(index).customer.name;
  }

  @override
  Color getColor(int index) {
    var situacao = _obterDadosAgendamento(index).situation.text();
    var map = Schedule.fromText(situacao);
    return map[ScheduleFromText.tColor];
  }

  Schedule _obterDadosAgendamento(int index) {
    //final dynamic meeting = appointments![index];
    //late final ScheduleModule meetingData;
    //if (meeting is ScheduleModule) {
    //  meetingData = meeting;
    // }

    return appointments![index];
  }
}
