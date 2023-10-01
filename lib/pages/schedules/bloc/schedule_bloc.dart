import 'package:agendamentos/pages/schedules/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:agendamentos/utils/schedule_utils.dart';
import 'package:bloc/bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(super.initialState) {
    on<SendToDB>(_saveToDB);
    on<CustomerChange>(_customerChange);
    on<ScheduleDateChange>(_dateChange);
    on<SituationChange>(_situationChange);
  }

  Future<void> _saveToDB(SendToDB event, emit) async {
    print("** resultado final para mandar pro banco de dados::");
    print("-> customer : ${state.customer.name} e o id: ${state.customer.id}");
    print("-> date: ${state.scheduleDate.toString()}");
    print("-> situation: ${state.situation.text()}");
    // agora, gravar a capa e depois ver como mandar os itens...
  }

  void _customerChange(CustomerChange event, emit) {
    emit(state.copyWith(customer: event.customer));
  }

  void _dateChange(ScheduleDateChange event, emit) {
    emit(state.copyWith(scheduleDate: event.scheduleDate));
  }

  void _situationChange(SituationChange event, emit) {
    emit(state.copyWith(situation: event.situation));
  }
}
