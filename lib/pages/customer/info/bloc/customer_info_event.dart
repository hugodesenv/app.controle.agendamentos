import 'package:agendamentos/model/customer.dart';

abstract class CustomerInfoEvent {}

class CustomerInfoEventRefresh extends CustomerInfoEvent {
  final Customer _customer;

  CustomerInfoEventRefresh({required customer}) : _customer = customer;

  Customer get customer => _customer;
}

class CustomerInfoEventDelete extends CustomerInfoEvent {}

class CustomerInfoEventOpenWhatsApp extends CustomerInfoEvent {
  final String? _number;

  CustomerInfoEventOpenWhatsApp(this._number);

  String get number => _number ?? '';
}
