import 'package:agendamentos/models/generic_model.dart';
import 'package:agendamentos/models/item.dart';
import 'package:agendamentos/models/schedule.dart';

class ScheduleItem extends GenericModel {
  late Schedule _schedule;
  late Item _item;
  late int _serviceMinutes;
  late double _price;
  late DateTime _dateChanged;

  ScheduleItem({
    Schedule? schedule,
    Item? item,
    int? serviceMinutes,
    double? price,
    DateTime? dateChanged,
  }) {
    _schedule = schedule ?? Schedule.empty();
    _item = item ?? Item.empty();
    _serviceMinutes = serviceMinutes ?? 0;
    _price = price ?? 0.0;
    _dateChanged = dateChanged ?? DateTime(1899);
  }

  static ScheduleItem empty() {
    return ScheduleItem();
  }

  Map toMap() {
    return {
      'action': action.text(),
      'fk_item': item.id,
      'service_minutes': serviceMinutes,
      'price': price,
    };
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  int get serviceMinutes => _serviceMinutes;

  set serviceMinutes(int value) {
    _serviceMinutes = value;
  }

  Item get item => _item;

  set item(Item value) {
    _item = value;
  }

  Schedule get schedule => _schedule;

  set schedule(Schedule value) {
    _schedule = value;
  }

  DateTime get dateChanged => _dateChanged;

  set dateChanged(DateTime value) {
    _dateChanged = value;
  }
}
