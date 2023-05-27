import '../../../../model/customer.dart';

enum TypeSuccess { tpDelete }

abstract class CustomerInfoState {}

class CustomerInfoStateInitial extends CustomerInfoState {}

class CustomerInfoStateRefresh extends CustomerInfoState {
  final Customer _customer;

  CustomerInfoStateRefresh({required customer}) : _customer = customer;

  Customer get customer => _customer;
}

class CustomerInfoStateDeleted extends CustomerInfoState {
  final Customer _customer;
  final String _message;

  CustomerInfoStateDeleted(this._customer, this._message);

  Customer get customer => _customer;

  String get message => _message;
}

class CustomerInfoStateLoading extends CustomerInfoState {
  final bool _isBusy;

  CustomerInfoStateLoading(this._isBusy);

  bool get isBusy => _isBusy;
}

class CustomerInfoStateSuccess extends CustomerInfoState {
  final String _message;
  final TypeSuccess _typeSuccess;

  CustomerInfoStateSuccess(this._message, this._typeSuccess);

  String get message => _message;

  TypeSuccess get typeSuccess => _typeSuccess;
}

class CustomerInfoStateFailure extends CustomerInfoState {
  final String _error;

  CustomerInfoStateFailure(this._error);

  String get error => _error;
}
