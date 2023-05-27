import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';

enum TpFromScreen { tQuery, tInfo }

class ArgsCustomerNew {
  Customer _customer;
  TpFromScreen _fromScreen;

  late CustomerQueryBloc _queryBloc;
  late CustomerInfoBloc _infoBloc;

  ArgsCustomerNew.query({customer, queryBloc})
      : _customer = customer ?? Customer.empty(),
        _queryBloc = queryBloc,
        _fromScreen = TpFromScreen.tQuery;

  ArgsCustomerNew.info({customer, infoBloc})
      : _customer = customer ?? Customer.empty(),
        _infoBloc = infoBloc,
        _fromScreen = TpFromScreen.tInfo;

  CustomerQueryBloc get queryBloc => _queryBloc;

  Customer get customer => _customer;

  set customer(Customer value) => _customer = value;

  CustomerInfoBloc get infoBloc => _infoBloc;

  TpFromScreen get fromScreen => _fromScreen;
}
