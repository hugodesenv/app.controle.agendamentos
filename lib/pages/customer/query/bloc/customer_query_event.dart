import 'package:agendamentos/assets/EnumTypeOpenCustomerQuery.dart';

import '../../../../model/customer.dart';

abstract class CustomerQueryEvent {}

class CustomerQueryEventRemoveFromList extends CustomerQueryEvent {
  final Customer _customer;

  CustomerQueryEventRemoveFromList(this._customer);

  Customer get customer => _customer;
}

class CustomerQueryEventAddToList extends CustomerQueryEvent {
  final Customer _customer;

  CustomerQueryEventAddToList(this._customer);

  Customer get customer => _customer;
}

class CustomerQueryEventFetchAll extends CustomerQueryEvent {}

class CustomerQueryEventOpen extends CustomerQueryEvent {
  final TypeOpen _typeOpen;

  CustomerQueryEventOpen(this._typeOpen);

  TypeOpen get typeOpen => _typeOpen;
}

class CustomerQueryEventOnChangedFilter extends CustomerQueryEvent {
  final String _value;

  CustomerQueryEventOnChangedFilter(this._value);

  String get value => _value.toLowerCase();
}
