import 'package:agendamentos/models/schedule_item.dart';
import 'package:flutter/material.dart';

import '../../../models/item.dart';

class AgendaItemProvider with ChangeNotifier {
  ScheduleItem _scheduleItem = ScheduleItem.empty();

  set scheduleItem(ScheduleItem? value) {
    _scheduleItem = value ?? ScheduleItem.empty();
    notifyListeners();
  }

  ScheduleItem get scheduleItem => _scheduleItem;

  changeItem(Item pItem) {
    scheduleItem.item = pItem;
    scheduleItem.serviceMinutes = pItem.serviceMinutes;
  }

  changeItemPrice(price) {
    scheduleItem.price = double.tryParse(price) ?? 0.0;
  }

  changeItemTimeService(String minutes) {
    scheduleItem.serviceMinutes = int.tryParse(minutes) ?? 0;
  }
}
