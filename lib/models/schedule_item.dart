import 'package:agendamentos/models/generic_model.dart';
import 'package:agendamentos/models/item.dart';
import 'package:agendamentos/models/schedule.dart';

class ScheduleItem extends GenericModel {
  late Schedule _schedule;
  late Item _item;
  late int _serviceMinutes;
  late double _price;

  ScheduleItem({
    Schedule? schedule,
    Item? item,
    int? serviceMinutes,
    double? price,
  }) {
    _schedule = schedule ?? Schedule.empty();
    _item = item ?? Item.empty();
    _serviceMinutes = serviceMinutes ?? 0;
    _price = price ?? 0.0;
  }

  static ScheduleItem empty() {
    return ScheduleItem();
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
}
