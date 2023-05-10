import '../../../../model/customer.dart';

abstract class CustomerQueryState {}

class CustomerQueryStateInitial extends CustomerQueryState {}

class CustomerQueryStateLoading extends CustomerQueryState {}

class CustomerQueryStateLoaded extends CustomerQueryState {
  List<Customer> _customers;

  CustomerQueryStateLoaded({required customers}) : _customers = customers;

  List<Customer> get customers => _customers;
}
