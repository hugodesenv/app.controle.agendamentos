import '../../../../assets/EnumTypeOpenCustomerQuery.dart';

abstract class CustomerQueryState {}

class CustomerQueryStateLoading extends CustomerQueryState {
  bool _busy;

  CustomerQueryStateLoading(this._busy);

  bool get busy => _busy;
}

class CustomerQueryStateRefresh extends CustomerQueryState {}

class CustomerQueryStateOpen extends CustomerQueryState {
  final TypeOpen _typeOpen;

  CustomerQueryStateOpen(this._typeOpen);

  TypeOpen get typeOpen => _typeOpen;
}
