import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/utils/api/schedule_utils.dart';
import '../../../models/customer.dart';
import '../../../models/schedule_item.dart';

class ScheduleState {
  late Schedule schedule;
  //late FormSubmissionStatus formStatus;
  //late FormSubmissionStatus itemsStatus;
  late ScheduleItem itemToModify;

  ScheduleState({
    Customer? customer,
    Employee? employee,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    //FormSubmissionStatus? formStatus,
    //FormSubmissionStatus? itemsStatus,
    List<ScheduleItem>? items,
    ScheduleItem? itemToModify,
  }) {
    schedule = Schedule(
      customer: customer,
      employee: employee,
      scheduleDate: scheduleDate,
      situation: situation,
      scheduleItem: items,
    );

    //this.formStatus = formStatus ?? FormSubmissionStatus.initial;
    //this.itemsStatus = itemsStatus ?? FormSubmissionStatus.initial;
    this.itemToModify = itemToModify ?? ScheduleItem.empty();
  }

  ScheduleState copyWith({
    Customer? customer,
    Employee? employee,
    DateTime? scheduleDate,
    ScheduleSituationEnum? situation,
    //FormSubmissionStatus? formStatus,
    //FormSubmissionStatus? itemsStatus,
    List<ScheduleItem>? items,
    ScheduleItem? itemToModify,
  }) {
    return ScheduleState(
      customer: customer ?? schedule.customer,
      employee: employee ?? schedule.employee,
      scheduleDate: scheduleDate ?? schedule.scheduleDate,
      situation: situation ?? schedule.situation,
      //formStatus: formStatus ?? this.formStatus,
      //itemsStatus: itemsStatus ?? this.itemsStatus,
      items: items ?? schedule.scheduleItem,
      itemToModify: itemToModify ?? this.itemToModify,
    );
  }
}
