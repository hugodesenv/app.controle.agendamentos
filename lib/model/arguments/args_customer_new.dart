import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';

class ArgsCustomerNew {
  Customer _customer;

  late CustomerInfoBloc _infoBloc;

  ArgsCustomerNew.query({customer, queryBloc}) : _customer = customer ?? Customer.empty();

  ArgsCustomerNew.info({customer, infoBloc})
      : _customer = customer ?? Customer.empty(),
        _infoBloc = infoBloc;

  Customer get customer => _customer;

  set customer(Customer value) => _customer = value;

  CustomerInfoBloc get infoBloc => _infoBloc;
}
