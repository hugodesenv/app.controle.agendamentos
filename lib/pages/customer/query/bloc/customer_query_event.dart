abstract class CustomerQueryEvent {}

/// find all customers in database
class CustomerQueryEventFetchAll extends CustomerQueryEvent {}

class CustomerQueryEventOnChangedFilter extends CustomerQueryEvent {
  final String _value;

  CustomerQueryEventOnChangedFilter(this._value);

  String get value => _value.toLowerCase();
}
