import 'package:agendamentos/pages/schedule/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedule/bloc/schedule_state.dart';
import 'package:bloc/bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(super.initialStatge) {
    on<ScheduleEventFindAll>(_findAll);
  }

  Future<void> _findAll(ScheduleEventFindAll event, emit) async {
    // buscar os dados da api aqui...
  }
}
