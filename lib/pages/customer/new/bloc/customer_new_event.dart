import 'package:agendamentos/model/customer.dart';

abstract class CustomerNewEvent {}

class CustomerNewEventSubmitted extends CustomerNewEvent {}

class CustomerNewEventOnChanged extends CustomerNewEvent {
  String? name;
  String? cellphone;

  CustomerNewEventOnChanged({this.name, this.cellphone});
}

class CustomerNewEventEditMode extends CustomerNewEvent {
  final Customer _customer;

  CustomerNewEventEditMode(this._customer);

  Customer get customer => _customer;
}
