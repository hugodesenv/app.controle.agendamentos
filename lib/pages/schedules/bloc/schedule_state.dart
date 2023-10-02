import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/models/schedule_item.dart';
import 'package:agendamentos/utils/schedule_utils.dart';

import '../../../models/customer.dart';

class ScheduleState {
  Schedule? schedule;

  ScheduleState();

  ScheduleState._initial({
    Customer? customer,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    List<ScheduleItem>? items,
    Employee? employee,
  }) {
    schedule = Schedule.copyWith(
      scheduleItem: items,
      situation: situation,
      scheduleDate: scheduleDate,
      customer: customer,
    );
  }

  ScheduleState copyWith({
    Customer? customer,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    List<ScheduleItem>? items,
    Employee? employee,
  }) {
    var instance = ScheduleState._initial(
      customer: customer,
      scheduleDate: scheduleDate,
      situation: situation,
      items: items,
      employee: employee,
    );

    return instance;
  }
}

class Initial extends ScheduleState {}
