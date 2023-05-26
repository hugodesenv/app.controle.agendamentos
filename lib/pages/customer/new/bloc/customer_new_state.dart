import '../../../../model/customer.dart';

abstract class CustomerNewState {}

class CustomerNewStateInitial extends CustomerNewState {}

class CustomerNewStateSuccess extends CustomerNewState {
  final Customer _customer;

  CustomerNewStateSuccess(this._customer);

  Customer get customer => _customer;
}

class CustomerNewStateLoaded extends CustomerNewState {}
