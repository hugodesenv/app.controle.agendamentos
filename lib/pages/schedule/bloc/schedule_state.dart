import '../../../models/schedule.dart';

class ScheduleState {
  List<Schedule> schedules;

  ScheduleState({required this.schedules});

  ScheduleState copyWith({required List<Schedule> scheduleList}) {
    return ScheduleState(schedules: scheduleList ?? this.schedules);
  }
}
