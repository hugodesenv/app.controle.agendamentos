import '../../../../model/customer.dart';

abstract class CustomerNewState {}

class CustomerNewStateInitial extends CustomerNewState {}

class CustomerNewStateSuccess extends CustomerNewState {
  final Customer _customer;
  final String _message;

  CustomerNewStateSuccess(this._customer, this._message);

  Customer get customer => _customer;

  String get message => _message;
}

class CustomerNewStateFailure extends CustomerNewState {
  final String _error;

  CustomerNewStateFailure(this._error);

  String get error => _error;
}

class CustomerNewStateLoaded extends CustomerNewState {}
