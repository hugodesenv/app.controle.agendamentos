import '../../../../assets/EnumTypeOpenCustomerQuery.dart';
import '../../../../model/customer.dart';

abstract class CustomerQueryState {}

class CustomerQueryStateLoading extends CustomerQueryState {
  bool _busy;

  CustomerQueryStateLoading(this._busy);

  bool get busy => _busy;
}

class CustomerQueryStateOpen extends CustomerQueryState {
  final TypeOpen _typeOpen;

  CustomerQueryStateOpen(this._typeOpen);

  TypeOpen get typeOpen => _typeOpen;
}

class CustomerQueryStateRefreshList extends CustomerQueryState {
  final List<Customer> _customers;

  CustomerQueryStateRefreshList(this._customers);

  List<Customer> get customers => _customers;
}

//remover dps...
class CustomerQueryStateTeste extends CustomerQueryState {}
