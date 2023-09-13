import 'package:agendamentos/repository/api/schedule_repository.dart';
import 'package:agendamentos/utils/displayFormatUtils.dart';
import 'package:agendamentos/utils/toColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../assets/constants/utilsConstantes.dart';
import 'bloc/schedules_bloc.dart';
import 'bloc/schedules_state.dart';
import 'model/schedules_datasource.dart';
import 'model/schedules_model.dart';

class ScheduleCalendar extends StatelessWidget {
  late SchedulesBloc _bloc;
  late Function(DateTime? date, Map values) _onListenerResults;

  ScheduleCalendar({
    Key? key,
    required SchedulesBloc bloc,
    required Function(DateTime? date, Map values) onListenerResults,
  }) : super(key: key) {
    _bloc = bloc;
    _onListenerResults = onListenerResults;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (_, SchedulesState state) {
        return SfCalendar(
          dataSource: ScheduleDataSource(state.schedules),
          todayHighlightColor: Theme.of(context).primaryColor,
          onTap: (calendarTapDetails) async => await _openDetails(context, calendarTapDetails),
          showDatePickerButton: true,
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
    if (details.targetElement == CalendarElement.appointment || details.targetElement == CalendarElement.agenda) {
      ScheduleModule scheduleModule = details.appointments![0];

      await showModalBottomSheet(
        context: context,
        shape: shapeModalBottomSheet,
        builder: (context) {
          String situation = scheduleModule.schedule.situation;
          String displaySituation = DisplayFormatUtils.scheduleSituation(situation);
          Color colorSituation = ToColorUtils.scheduleSituation(situation);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListTile(
                        title: Text(
                          displaySituation,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: colorSituation,
                          ),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    padding: const EdgeInsets.only(top: 10.0),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(child: Text("Alterar")),
                        const PopupMenuItem(
                          child: Text(
                            "Excluir",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0, bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_2_outlined),
                        title: const Text("Nome"),
                        subtitle: Text(scheduleModule.schedule.customer.name),
                      ),
                      ListTile(
                        leading: const Icon(Icons.local_phone_outlined),
                        title: const Text("Celular"),
                        subtitle: Text(scheduleModule.schedule.customer.cellphone),
                      ),
                      ListTile(
                        leading: const Icon(Icons.timer_sharp),
                        title: const Text("Tempo total (Minutos)"),
                        subtitle: Text(scheduleModule.schedule.totalMinutes.toString()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.attach_money_rounded),
                        title: const Text("Preço R\$"),
                        subtitle: Text(scheduleModule.schedule.totalPrice.toString()),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      );
    }
  }

  _onResultValues(DateTime? date, Map totals) {
    String key = DateFormat.yMMMMd().format(date!);
    totals[key] != null ? _onListenerResults(date, totals[key]) : _onListenerResults(date, {});
  }
}
