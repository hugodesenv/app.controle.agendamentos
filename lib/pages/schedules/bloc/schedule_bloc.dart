import 'package:agendamentos/pages/schedules/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:bloc/bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(super.initialState) {
    on<SendToDB>(_saveToDB);
    on<CustomerChange>(_customerChange);
    on<ScheduleDateChange>(_dateChange);
    on<SituationChange>(_situationChange);
    on<EmployeeChange>(_employeeChange);
  }

  Future<void> _saveToDB(SendToDB event, emit) async {
    var mapData = state.schedule?.toMap();
    print(mapData);
  }

  void _customerChange(CustomerChange event, emit) {
    emit(state.copyWith(customer: event.customer));
  }

  void _employeeChange(EmployeeChange event, emit) {
    emit(state.copyWith(employee: event.employee));
  }

  void _dateChange(ScheduleDateChange event, emit) {
    emit(state.copyWith(scheduleDate: event.scheduleDate));
  }

  void _situationChange(SituationChange event, emit) {
    emit(state.copyWith(situation: event.situation));
  }
}
