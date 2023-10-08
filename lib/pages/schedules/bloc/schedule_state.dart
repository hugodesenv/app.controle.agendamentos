import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/utils/schedule_utils.dart';

import '../../../models/customer.dart';

class ScheduleState {
  late Schedule schedule;

  ScheduleState({
    Customer? customer,
    Employee? employee,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
  }) {
    schedule = Schedule(
      customer: customer,
      employee: employee,
      scheduleDate: scheduleDate,
      situation: situation,
    );
  }

  ScheduleState copyWith({
    Customer? customer,
    Employee? employee,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
  }) {
    return ScheduleState(
      customer: customer ?? schedule.customer,
      employee: employee ?? schedule.employee,
      scheduleDate: scheduleDate ?? schedule.scheduleDate,
      situation: situation ?? schedule.situation,
    );
  }
}

class Initial extends ScheduleState {}
