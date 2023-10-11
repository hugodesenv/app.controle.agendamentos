import 'package:agendamentos/enum/form_submission_status.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:agendamentos/repository/api/schedule_repository.dart';
import 'package:bloc/bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(super.initialState) {
    on<SendToDB>(_saveToDB);
    on<CustomerChange>(_customerChange);
    on<ScheduleDateChange>(_dateChange);
    on<SituationChange>(_situationChange);
    on<EmployeeChange>(_employeeChange);
    on<ItemChange>(_itemChange);
  }

  _itemChange(ItemChange event, emit) {}

  Future<void> _saveToDB(SendToDB event, emit) async {
    emit(state.copyWith(formStatus: FormSubmissionStatus.inProgress));
    try {
      ScheduleRepository repository = ScheduleRepository.instance;
      var res = repository.save(state.schedule);
      emit(state.copyWith(formStatus: FormSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(formStatus: FormSubmissionStatus.failure));
    }
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
