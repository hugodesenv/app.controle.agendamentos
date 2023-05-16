abstract class CustomerNewEvent {}

class CustomerNewEventSubmitted extends CustomerNewEvent {}

class CustomerNewEventOnChanged extends CustomerNewEvent {
  String? name;
  String? cellphone;

  CustomerNewEventOnChanged({this.name, this.cellphone});
}
