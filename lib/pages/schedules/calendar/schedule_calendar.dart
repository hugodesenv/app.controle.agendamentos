import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../assets/constants/utilsConstantes.dart';
import 'bloc/schedules_bloc.dart';
import 'bloc/schedules_state.dart';
import 'model/schedules_datasource.dart';
import 'model/schedules_model.dart';

class ScheduleCalendar extends StatelessWidget {
  late SchedulesBloc _bloc;

  ScheduleCalendar({Key? key, required SchedulesBloc bloc}) : super(key: key) {
    _bloc = bloc;
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
  }

  _openDetails(BuildContext context, CalendarTapDetails details) async {
    if (details.targetElement == CalendarElement.appointment || details.targetElement == CalendarElement.agenda) {
      ScheduleModule scheduleModule = details.appointments![0];

      await showModalBottomSheet(
        context: context,
        shape: shapeModalBottomSheet,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Detalhamento',
                  textAlign: TextAlign.center,
                  style: textStyleTitleModalBottomSheet(context),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: MediaQuery.of(context).viewInsets.bottom + 16.0),
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
}
