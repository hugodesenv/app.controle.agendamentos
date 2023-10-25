import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/models/item.dart';
import 'package:agendamentos/models/schedule_item.dart';
import '../../../models/customer.dart';
import '../../../models/schedule.dart';

abstract class ScheduleEvent {}

class SendToDB extends ScheduleEvent {}

class CustomerChange extends ScheduleEvent {
  late Customer customer;

  CustomerChange(this.customer);
}

class EmployeeChange extends ScheduleEvent {
  late Employee employee;

  EmployeeChange(this.employee);
}

class ScheduleDateChange extends ScheduleEvent {
  DateTime? scheduleDate;
  ScheduleDateChange(this.scheduleDate);
}

class SituationChange extends ScheduleEvent {
  ScheduleSituationEnum? situation;
  SituationChange(this.situation);
}

class ItemChange extends ScheduleEvent {
  Item item;
  ItemChange(this.item);
}

/// Quando o usuário clica sob o item na lista e abrimos o detalhamento dele para edição/inserção.
class ItemShow extends ScheduleEvent {
  ScheduleItem? _scheduleItem;

  ItemShow({ScheduleItem? scheduleItem}) {
    _scheduleItem = scheduleItem;
  }

  ScheduleItem get scheduleItem => _scheduleItem ?? ScheduleItem.empty();
}

class ItemSave extends ScheduleEvent {}

class ItemDelete extends ScheduleEvent {
  ScheduleItem scheduleItem;
  ItemDelete({required this.scheduleItem});
}

class ItemPriceChange extends ScheduleEvent {
  dynamic price;
  ItemPriceChange(this.price);
}

class ItemMinutesChange extends ScheduleEvent {
  dynamic minutes;
  ItemMinutesChange(this.minutes);
}
