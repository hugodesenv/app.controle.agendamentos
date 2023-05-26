import '../../../../model/customer.dart';

abstract class CustomerQueryState {}

class CustomerQueryStateLoading extends CustomerQueryState {
  final bool _busy;

  CustomerQueryStateLoading(this._busy);

  bool get busy => _busy;
}

class CustomerQueryStateRefreshList extends CustomerQueryState {
  final List<Customer> _customers;

  CustomerQueryStateRefreshList(this._customers);

  List<Customer> get customers => _customers;
}
