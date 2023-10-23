import 'package:agendamentos/models/schedule.dart';
import '../../../models/schedule_item.dart';

class ScheduleState {
  late Schedule schedule;
  late ScheduleItem currentItem;

  ScheduleState({
    Schedule? schedule,
    ScheduleItem? currentItem,
  }) {
    this.schedule = schedule ?? Schedule.empty();
    this.currentItem = currentItem ?? ScheduleItem.empty();
  }

  ScheduleState copyWith({
    Schedule? schedule,
    ScheduleItem? currentItem,
  }) {
    return ScheduleState(
      schedule: schedule ?? this.schedule,
      currentItem: currentItem ?? this.currentItem,
    );
  }
}
