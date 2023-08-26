import '../../../../models/customer.dart';

abstract class CustomerQueryEvent {}

class CustomerQueryEventFetchAll extends CustomerQueryEvent {}

class CustomerQueryEventOnChangedFilter extends CustomerQueryEvent {
  final String _value;

  CustomerQueryEventOnChangedFilter(this._value);

  String get value => _value.toLowerCase();
}

class CustomerQueryEventUpdated extends CustomerQueryEvent {
  List<Customer> customers;

  CustomerQueryEventUpdated({required this.customers});
}