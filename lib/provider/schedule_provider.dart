import 'package:agendamentos/enum/schedule_situation_enum.dart';
import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/models/employee.dart';
import 'package:flutter/foundation.dart';

import '../models/generic_model.dart';
import '../models/schedule.dart';
import '../models/schedule_item.dart';

class ScheduleProvider with ChangeNotifier {
  late Schedule _schedule;

  ScheduleProvider() {
    _schedule = Schedule.empty();
  }

  Schedule get schedule => _schedule;

  changeCustomer(Customer? pCustomer) {
    _schedule = schedule.copyWith(customer: pCustomer);
  }

  changeDate(DateTime? pDate) {
    _schedule = schedule.copyWith(dateChanged: pDate);
  }

  changeEmployee(Employee? pEmployee) {
    _schedule = schedule.copyWith(employee: pEmployee);
  }

  changeSituation(ScheduleSituationEnum? pSituation) {
    _schedule = schedule.copyWith(situation: pSituation);
  }

  addItem(ScheduleItem currentItem) {
    schedule.saveItem(currentItem);

    var itemsActives = schedule.filterItems(ActionAPI.tDeleted, false);
    schedule.scheduleItem = itemsActives;

    notifyListeners();
  }

  save() {
    print("88 oi 88");
    print(schedule.toMap());
  }
}
