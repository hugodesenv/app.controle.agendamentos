import 'package:agendamentos/model/customer.dart';

abstract class CustomerInfoEvent {}

class CustomerInfoEventInitial extends CustomerInfoEvent {}

class CustomerInfoEventDefaultState extends CustomerInfoEvent {
  Customer? _customer;

  CustomerInfoEventDefaultState({required Customer customer}) : _customer = customer;

  Customer get customer => _customer!;
}
