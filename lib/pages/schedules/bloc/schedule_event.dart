abstract class ScheduleEvent {}

class SendToDB extends ScheduleEvent {}

class CustomerChange extends ScheduleEvent {
  String customerID;

  CustomerChange(this.customerID);
}

class ScheduleDateChange extends ScheduleEvent {
  DateTime scheduleDate;

  ScheduleDateChange(this.scheduleDate);
}

class SituationChange extends ScheduleEvent {
  String situation;

  SituationChange(this.situation);
}
