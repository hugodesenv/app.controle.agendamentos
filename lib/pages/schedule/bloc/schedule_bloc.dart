import 'package:agendamentos/pages/schedule/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedule/bloc/schedule_state.dart';
import 'package:bloc/bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(super.initialState) {
    on<ScheduleEventLoad>(_load);
  }

  Future<void> _load(ScheduleEventLoad event, emit) async {

  }
}
