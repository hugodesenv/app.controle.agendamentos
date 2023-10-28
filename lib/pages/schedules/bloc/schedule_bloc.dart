import 'package:agendamentos/models/generic_model.dart';
import 'package:agendamentos/models/schedule_item.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:agendamentos/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';

import '../../../models/item.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(super.initialState) {
    // schedules
    on<CustomerChange>(_customerChange);
    on<ScheduleDateChange>(_dateChange);
    on<EmployeeChange>(_employeeChange);
    on<SituationChange>(_situationChange);
    // items
    on<ItemChange>(_itemChange);
    on<ItemShow>(_itemShow);
    on<ItemSave>(_itemSave);
    on<ItemDelete>(_deleteItem);
    on<ItemPriceChange>(_itemPriceChange);
    on<ItemMinutesChange>(_itemMinutesChange);
    // others
    on<SendToDB>(_saveToDB);
  }

  void _customerChange(CustomerChange event, emit) {
    var schedule = state.schedule.copyWith(customer: event.customer);
    emit(state.copyWith(schedule: schedule));
  }

  void _dateChange(ScheduleDateChange event, emit) {
    var schedule = state.schedule.copyWith(dateChanged: event.scheduleDate);
    emit(state.copyWith(schedule: schedule));
  }

  void _employeeChange(EmployeeChange event, emit) {
    var schedule = state.schedule.copyWith(employee: event.employee);
    emit(state.copyWith(schedule: schedule));
  }

  void _situationChange(SituationChange event, emit) {
    var schedule = state.schedule.copyWith(situation: event.situation);
    emit(state.copyWith(schedule: schedule));
  }

  void _itemChange(ItemChange event, emit) {
    Item item = event.item;

    ScheduleItem scheduleItem = state.currentItem;
    scheduleItem.item = item;
    scheduleItem.serviceMinutes = item.serviceMinutes;

    emit(state.copyWith(currentItem: scheduleItem));
  }

  void _itemShow(ItemShow event, emit) {
    emit(state.copyWith(currentItem: event.scheduleItem));
  }

  Future<void> _saveToDB(SendToDB event, emit) async {
    ScheduleRepository repository = ScheduleRepository.instance;
    var res = repository.save(state.schedule);
  }

  void _itemSave(ItemSave event, emit) {
    var schedule = state.schedule;
    schedule.saveItem(state.currentItem);

    var itemsActives = state.schedule.filterItems(ActionAPI.tDeleted, false);
    schedule.scheduleItem = itemsActives;

    emit(state.copyWith(schedule: schedule));
  }

  void _deleteItem(ItemDelete event, emit) {
    var schedule = state.schedule;
    schedule.removeItem(event.scheduleItem);

    var items = schedule.filterItems(ActionAPI.tDeleted, false);
    schedule.scheduleItem = items;

    emit(state.copyWith(schedule: schedule));
  }

  void _itemPriceChange(ItemPriceChange event, emit) {
    var item = state.currentItem;
    item.price = double.tryParse(event.price) ?? 0.0;
    emit(state.copyWith(currentItem: item));
  }

  void _itemMinutesChange(ItemMinutesChange event, emit) {
    var item = state.currentItem;
    item.serviceMinutes = int.tryParse(event.minutes) ?? 0;
    emit(state.copyWith(currentItem: item));
  }
}
