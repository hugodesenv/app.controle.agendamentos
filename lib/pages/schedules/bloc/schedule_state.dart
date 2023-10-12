import 'package:agendamentos/enum/form_submission_status.dart';
import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/utils/schedule_utils.dart';

import '../../../models/customer.dart';
import '../../../models/schedule_item.dart';

class ScheduleState {
  late Schedule schedule;
  late FormSubmissionStatus formStatus;
  late FormSubmissionStatus itemsStatus;

  ScheduleState({
    Customer? customer,
    Employee? employee,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    FormSubmissionStatus? formStatus,
    FormSubmissionStatus? itemsStatus,
    List<ScheduleItem>? items,
  }) {
    schedule = Schedule(
      customer: customer,
      employee: employee,
      scheduleDate: scheduleDate,
      situation: situation,
      scheduleItem: items,
    );

    this.formStatus = formStatus ?? FormSubmissionStatus.initial;
    this.itemsStatus = itemsStatus ?? FormSubmissionStatus.initial;
  }

  ScheduleState copyWith({
    Customer? customer,
    Employee? employee,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    FormSubmissionStatus? formStatus,
    FormSubmissionStatus? itemsStatus,
    List<ScheduleItem>? items,
  }) {
    return ScheduleState(
      customer: customer ?? schedule.customer,
      employee: employee ?? schedule.employee,
      scheduleDate: scheduleDate ?? schedule.scheduleDate,
      situation: situation ?? schedule.situation,
      formStatus: formStatus ?? this.formStatus,
      itemsStatus: itemsStatus ?? this.itemsStatus,
      items: items ?? schedule.scheduleItem,
    );
  }
}

class Initial extends ScheduleState {}

class ItemDetail extends ScheduleState {
  ScheduleItem scheduleItem;
  ItemDetail(this.scheduleItem);
}
