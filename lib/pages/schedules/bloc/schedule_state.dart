import '../../../models/item.dart';

class ScheduleState {
  late String _customerID;
  late List<Item> _itemsInsert;
  late List<Item> _itemsUpdate;
  late DateTime _scheduleDate;
  late String _situation;

  ScheduleState(
    String customerID,
    DateTime scheduleDate,
    String situation,
    List<Item> itemsInsert,
    List<Item> itemsUpdate,
  ) {
    _itemsInsert = itemsInsert;
    _itemsUpdate = itemsUpdate;
    _customerID = customerID;
    _situation = situation;
    _scheduleDate = scheduleDate;
  }

  ScheduleState copyWith({
    String? customerID,
    DateTime? scheduleDate,
    String? situation,
    List<Item>? itemsInsert,
    List<Item>? itemsUpdate,
  }) {
    return ScheduleState(
      customerID ?? _customerID,
      scheduleDate ?? _scheduleDate,
      situation ?? _situation,
      itemsInsert ?? _itemsInsert,
      itemsUpdate ?? _itemsUpdate,
    );
  }

  List<Item> get itemsUpdate => _itemsUpdate;

  set itemsUpdate(List<Item> value) {
    _itemsUpdate = value;
  }

  List<Item> get itemsInsert => _itemsInsert;

  set itemsInsert(List<Item> value) {
    _itemsInsert = value;
  }

  String get customerID => _customerID;

  set customerID(String value) {
    _customerID = value;
  }

  DateTime get scheduleDate => _scheduleDate;

  set scheduleDate(DateTime value) {
    _scheduleDate = value;
  }

  String get situation => _situation;

  set situation(String value) {
    _situation = value;
  }
}
