import '../model/schedules_model.dart';

class SchedulesState {
  List<ScheduleModule> schedules = [];
  Map totals = {};

  SchedulesState({List<ScheduleModule>? schedules, Map? totals})
      : schedules = schedules ?? [],
        totals = totals ?? {};
}
