import 'package:agendamentos/model/customer.dart';

class ArgsCustomerInfo {
  final Customer _customer;

  ArgsCustomerInfo({required customer}) : _customer = customer;

  Customer get customer => _customer;
}
