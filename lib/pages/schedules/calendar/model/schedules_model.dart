import '../../../../models/schedule.dart';

class ScheduleModule {
  final Schedule schedule;

  ScheduleModule(this.schedule);

  String get eventName => schedule.customer.name;
}
