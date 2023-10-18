import 'package:agendamentos/models/generic_model.dart';
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
      (event, emit) => emit(state.copyWith(itemToModify: event.scheduleItem)),
    );
    on<ItemSave>(_modifyItemList);
    on<ItemDelete>(_deleteItem);
  }

  Future<void> _saveToDB(SendToDB event, emit) async {
    try {
      ScheduleRepository repository = ScheduleRepository.instance;
      var res = repository.save(state.schedule);
    } catch (e) {}
  }

  void _modifyItemList(ItemSave event, emit) {
    state.schedule.modifyItem(event.scheduleItem);

    List<ScheduleItem> filtered =
        state.schedule.filterItems(ActionAPI.tDeleted, false);

    emit(state.copyWith(items: filtered));
  }

  void _deleteItem(ItemDelete event, emit) {
    state.schedule.removeItem(event.scheduleItem);

    List<ScheduleItem> filtered =
        state.schedule.filterItems(ActionAPI.tDeleted, false);

    emit(state.copyWith(items: filtered));
  }
}
