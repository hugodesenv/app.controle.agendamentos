abstract class HomeEvent {}

class HomeEventInitial extends HomeEvent {}

class HomeEventSignOut extends HomeEvent {}

class HomeEventsScheduleListener extends HomeEvent {
  Map totals;
  DateTime? date;

  HomeEventsScheduleListener(this.date, this.totals);
}
