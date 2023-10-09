import 'package:agendamentos/enum/form_submission_status.dart';
import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/utils/schedule_utils.dart';

import '../../../models/customer.dart';

class ScheduleState {
  late Schedule schedule;
  late FormSubmissionStatus formStatus;

  ScheduleState({
    Customer? customer,
    Employee? employee,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    FormSubmissionStatus? formStatus,
  }) {
    schedule = Schedule(
      customer: customer,
      employee: employee,
      scheduleDate: scheduleDate,
      situation: situation,
    );

    this.formStatus = formStatus ?? FormSubmissionStatus.initial;
  }

  ScheduleState copyWith({
    Customer? customer,
    Employee? employee,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    FormSubmissionStatus? formStatus,
  }) {
    return ScheduleState(
      customer: customer ?? schedule.customer,
      employee: employee ?? schedule.employee,
      scheduleDate: scheduleDate ?? schedule.scheduleDate,
      situation: situation ?? schedule.situation,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}

class Initial extends ScheduleState {}
