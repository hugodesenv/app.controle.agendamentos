import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';

class ArgsCustomerInfo {
  final Customer _customer;
  final CustomerQueryBloc _customerQueryBloc;

  ArgsCustomerInfo({required customer, required customerQueryBloc})
      : _customer = customer,
        _customerQueryBloc = customerQueryBloc;

  CustomerQueryBloc get customerQueryBloc => _customerQueryBloc;

  Customer get customer => _customer;
}
