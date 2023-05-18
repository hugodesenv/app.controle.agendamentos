import 'package:agendamentos/model/customer.dart';

abstract class CustomerInfoEvent {}

class CustomerInfoEventInitial extends CustomerInfoEvent {}

class CustomerInfoEventDefaultState extends CustomerInfoEvent {
  final Customer? _customer;

  CustomerInfoEventDefaultState({required Customer customer}) : _customer = customer;

  Customer get customer => _customer!;
}

class CustomerInfoEventOpenWhatsApp extends CustomerInfoEvent {
  final String? _number;

  CustomerInfoEventOpenWhatsApp(this._number);

  String get number => _number ?? '';
}

class CustomerInfoEventDelete extends CustomerInfoEvent {}
