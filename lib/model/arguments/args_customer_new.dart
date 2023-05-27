import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';

class ArgsCustomerNew {
  Customer _customer;
  CustomerQueryBloc queryBloc;

  ArgsCustomerNew({customer, required this.queryBloc})
      : _customer = customer ?? Customer.empty();

  Customer get customer => _customer;

  set customer(Customer value) => _customer = value;
}
