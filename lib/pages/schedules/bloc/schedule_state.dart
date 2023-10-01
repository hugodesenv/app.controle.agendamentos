import 'package:agendamentos/utils/schedule_utils.dart';

import '../../../models/customer.dart';

class ScheduleState {
  Customer? _customer;
  DateTime? _scheduleDate;
  ScheduleSituationEnum? _situation;

  /// {
  ///    modified: true,
  ///    object: ScheduleItem()...
  /// }
  List<Map>? _items;

  ScheduleState();

  ScheduleState._initial(
    Customer? customer,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    List<Map>? items,
  ) {
    _items = items;
    _customer = customer;
    _situation = situation;
    _scheduleDate = scheduleDate;
  }

  ScheduleState copyWith({
    Customer? customer,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    List<Map>? items,
  }) {
    return ScheduleState._initial(
      customer ?? _customer,
      scheduleDate ?? _scheduleDate,
      situation ?? _situation,
      items ?? _items,
    );
  }

  List<Map> get items => _items ?? [];

  set items(List<Map> value) {
    _items = value;
  }

  ScheduleSituationEnum get situation => _situation ?? ScheduleSituationEnum.UNDEFINED;

  set situation(ScheduleSituationEnum value) {
    _situation = value;
  }

  DateTime get scheduleDate => _scheduleDate ?? DateTime.timestamp();

  set scheduleDate(DateTime value) {
    _scheduleDate = value;
  }

  Customer get customer => _customer ?? Customer.empty();

  set customer(Customer value) {
    _customer = value;
  }
}

class Initial extends ScheduleState {}
