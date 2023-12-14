import 'package:agendamentos/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'model/agenda_datasource.dart';

class AgendaCalendario extends StatelessWidget {
  late Function(DateTime data) _onDataSelecionada;
  late Function(Schedule scheduleModule) _onCliqueAgendamento;
  late Function(DateTime data) _onCliqueAgendamentoLivre;
  late List<Schedule> _agendamentos;

  AgendaCalendario({
    Key? key,
    required Function(Schedule scheduleModule) onCliqueAgendamento,
    required Function(DateTime date) onCliqueAgendamentoLivre,
    required List<Schedule> agendamentos,
    required Function(DateTime? data) onDataSelecionada,
  }) : super(key: key) {
    _agendamentos = agendamentos;
    _onCliqueAgendamento = onCliqueAgendamento;
    _onCliqueAgendamentoLivre = onCliqueAgendamentoLivre;
    _onDataSelecionada = onDataSelecionada;
  }

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      dataSource: AgendaDataSource(_agendamentos),
      todayHighlightColor: Theme.of(context).primaryColor,
      showDatePickerButton: true,
      onTap: (detail) async {
        await abrirDetalhe(context, detail, false);
      },
      onSelectionChanged: (calendarSelectionDetails) {
        _onDataSelecionada(calendarSelectionDetails.date!);
      },
      onViewChanged: (viewChangedDetails) {
        _onDataSelecionada(viewChangedDetails.visibleDates[0]);
      },
      onLongPress: (detail) async {
        await abrirDetalhe(context, detail, true);
      },
      allowedViews: const [
        CalendarView.day,
        CalendarView.month,
        CalendarView.schedule,
        CalendarView.week,
        CalendarView.workWeek,
      ],
    );
  }

  abrirDetalhe(
    BuildContext context,
    CalendarTouchDetails det,
    bool longPress,
  ) async {
    switch (det.targetElement) {
      case CalendarElement.appointment:
      case CalendarElement.agenda:
        {
          Schedule apontamento = det.appointments![0];
          _onCliqueAgendamento(apontamento);
        }
        break;
      case CalendarElement.calendarCell:
        {
          if (longPress == true) {
            int length = det.appointments?.length ?? 0;
            if (length == 0) {
              _onCliqueAgendamentoLivre(det.date ?? DateTime.timestamp());
            }
          }
        }
        break;
      case CalendarElement.header:
      case CalendarElement.viewHeader:
      case CalendarElement.allDayPanel:
      case CalendarElement.moreAppointmentRegion:
      case CalendarElement.resourceHeader:
        break;
    }
  }
}