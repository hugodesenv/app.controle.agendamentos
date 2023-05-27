import 'package:agendamentos/model/customer.dart';

abstract class CustomerNewEvent {}

class CustomerNewEventSubmitted extends CustomerNewEvent {}

class CustomerNewEventOnChanged extends CustomerNewEvent {
  String? name;
  String? cellphone;

  CustomerNewEventOnChanged({this.name, this.cellphone});
}

class CustomerNewEventInitial extends CustomerNewEvent {
  final Customer _customer;

  CustomerNewEventInitial({required customer}) : _customer = customer ?? Customer.empty();

  Customer get customer => _customer;
}
