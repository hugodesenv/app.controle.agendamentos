import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/schedule_item.dart';
import 'package:agendamentos/utils/schedule_utils.dart';
import '../../../models/customer.dart';

abstract class ScheduleEvent {}

class SendToDB extends ScheduleEvent {}

class CustomerChange extends ScheduleEvent {
  late Customer customer;

  CustomerChange(String id, String name) {
    customer = Customer(id: id, name: name);
  }
}

class EmployeeChange extends ScheduleEvent {
  late Employee employee;

  EmployeeChange(String id, String name) {
    employee = Employee(id: id, name: name);
  }
}

class ScheduleDateChange extends ScheduleEvent {
  DateTime? scheduleDate;
  ScheduleDateChange(this.scheduleDate);
}

class SituationChange extends ScheduleEvent {
  ScheduleSituationEnum? situation;
  SituationChange(this.situation);
}

// show the details from item when it is clicked or, the users wants a new
class ItemChange extends ScheduleEvent {
  late ScheduleItem? item;
  ItemChange({this.item});
}

class ItemSave extends ScheduleEvent {
  late ScheduleItem? item;
  ItemSave({this.item});
}
