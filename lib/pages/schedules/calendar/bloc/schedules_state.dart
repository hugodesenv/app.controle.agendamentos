import '../model/schedules_model.dart';

class SchedulesState {
  List<ScheduleModule> schedules = [];

  SchedulesState({List<ScheduleModule>? schedules}) : schedules = schedules ?? [];
}
