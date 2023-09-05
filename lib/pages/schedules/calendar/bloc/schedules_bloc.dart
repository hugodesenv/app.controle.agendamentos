import 'package:agendamentos/pages/schedules/calendar/bloc/schedules_event.dart';
import 'package:agendamentos/pages/schedules/calendar/bloc/schedules_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../repository/api/schedule_repository.dart';
import '../model/schedules_model.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc(super.initialState) {
    on<SchedulesEventLoad>(_loadAll);
  }

  _loadAll(SchedulesEventLoad event, emit) async {
    print("====> schedules_bloc _loadAll");

    var repository = ScheduleRepository.instance;
    var scheduleResult = await repository.findAll() as List<ScheduleModule>;
    emit(SchedulesState(schedules: scheduleResult));
  }
}
