import 'package:agendamentos/enum/form_submission_status.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:agendamentos/repository/api/schedule_repository.dart';
import 'package:bloc/bloc.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(super.initialState) {
    on<SendToDB>(_saveToDB);
    on<CustomerChange>((event, emit) {
      emit(state.copyWith(customer: event.customer));
    });
    on<ScheduleDateChange>((event, emit) {
      emit(state.copyWith(scheduleDate: event.scheduleDate));
    });
    on<SituationChange>((event, emit) {
      emit(state.copyWith(situation: event.situation));
    });
    on<EmployeeChange>((event, emit) {
      emit(state.copyWith(employee: event.employee));
    });
    on<ItemChange>((event, emit) {
      emit(ItemDetail(event.item));
    });
    on<ItemSave>(_addItem);
  }

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

  _addItem(ItemSave event, emit) {
    // fazer a logica para alterar essa instancia na lista e fazer o refresh
    print("** resultado aqui no bloc:");
    print(event.item?.serviceMinutes.toString());
  }
}
