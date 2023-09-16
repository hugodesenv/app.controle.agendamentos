import '../../../../models/schedule.dart';

class ScheduleModule {
  final DateTime _eventDate;
  final Schedule _schedule;

  ScheduleModule({Schedule? schedule, required DateTime eventDate})
      : _schedule = schedule ?? Schedule.empty(),
        _eventDate = eventDate;

  factory ScheduleModule.empty() {
    return ScheduleModule(eventDate: DateTime.timestamp(), schedule: Schedule.empty());
  }

  Schedule get schedule => _schedule;

  String get eventName => schedule.customer.name;

  //incluir setter
  DateTime get eventDate => _eventDate;
}
