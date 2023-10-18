import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/schedule_item.dart';
import 'package:agendamentos/utils/api/schedule_utils.dart';
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

/// Quando o usuário clica sob o item na lista e abrimos o detalhamento dele para edição/inserção.
class ItemShow extends ScheduleEvent {
  ScheduleItem? _scheduleItem;

  ItemShow({ScheduleItem? scheduleItem}) {
    _scheduleItem = scheduleItem;
  }

  ScheduleItem get scheduleItem => _scheduleItem ?? ScheduleItem.empty();
}

class ItemSave extends ScheduleEvent {
  ScheduleItem scheduleItem;
  ItemSave({required this.scheduleItem});
}

class ItemDelete extends ScheduleEvent {
  ScheduleItem scheduleItem;
  ItemDelete({required this.scheduleItem});
}
