import 'package:agendamentos/enum/form_submission_status.dart';
import 'package:agendamentos/models/schedule_item.dart';
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
    on<ItemShow>(
      (event, emit) => emit(ItemDetail(event.scheduleItem)),
    );
    on<ItemSave>(_modifyItemList);
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

  void _modifyItemList(ItemSave event, emit) {
    ScheduleItem item = event.scheduleItem;
    int index = state.schedule.scheduleItem.indexOf(item);

    if (index == -1) {
      state.schedule.scheduleItem.add(item);
      print("** contagem {${state.schedule.scheduleItem.length}}");
    } else {
      state.schedule.scheduleItem[index] = item;
    }

    emit(state.copyWith(itemsStatus: FormSubmissionStatus.inProgress));
  }
}
