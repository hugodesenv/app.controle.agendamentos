import 'package:agendamentos/pages/schedules/calendar/bloc/schedules_event.dart';
import 'package:agendamentos/pages/schedules/calendar/bloc/schedules_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../repository/schedule_repository.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc(super.initialState) {
    on<SchedulesEventLoad>(_loadAll);
  }

  _loadAll(SchedulesEventLoad event, emit) async {
    var repository = ScheduleRepository.instance;
    Map scheduleResult = await repository.findAll();
    emit(SchedulesState(
      schedules: scheduleResult['schedules'],
      totals: scheduleResult['totals'],
    ));
  }
}
