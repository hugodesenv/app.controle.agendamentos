import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';

enum TSource { tInfoScreen, tQueryScreen }

class ArgsCustomerNew {
  Customer _customer;
  final TSource _source;

  late CustomerInfoBloc _infoBloc;

  ArgsCustomerNew.query({customer, queryBloc})
      : _customer = customer ?? Customer.empty(),
        _source = TSource.tQueryScreen;

  ArgsCustomerNew.info({customer, infoBloc})
      : _customer = customer ?? Customer.empty(),
        _infoBloc = infoBloc,
        _source = TSource.tInfoScreen;

  Customer get customer => _customer;

  set customer(Customer value) => _customer = value;

  CustomerInfoBloc get infoBloc => _infoBloc;

  TSource get source => _source;
}
