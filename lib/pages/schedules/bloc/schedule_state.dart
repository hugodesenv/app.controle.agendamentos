import 'package:agendamentos/enum/form_submission_status.dart';
import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/utils/schedule_utils.dart';

import '../../../models/customer.dart';
import '../../../models/item.dart';
import '../../../models/schedule_item.dart';

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

    // apenas teste...
    final List<ScheduleItem> _items = [
      ScheduleItem(
        item: Item(description: 'Corte de Batata'),
        price: 120.0,
        serviceMinutes: 30,
      ),
      ScheduleItem(
        item: Item(description: 'Unha'),
        price: 77.0,
        serviceMinutes: 60,
      ),
    ];

    schedule.scheduleItem = _items;

    /// remover depois

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

class ItemDetail extends ScheduleState {
  ScheduleItem? scheduleItem;
  ItemDetail(this.scheduleItem);
}
