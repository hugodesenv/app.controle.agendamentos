import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/pages/customer/query/customer_query.dart';
import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/pages/login/bloc/login_bloc.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home/home.dart';
import 'pages/login/login.dart';

const ROUTE_HOME = '/home';
const ROUTE_LOGIN = '/login';
const ROUTE_CUSTOMER_QUERY = '/customer_query';

appRoutes() => {
      ROUTE_HOME: (context) => BlocProvider(
            create: (context) => HomeBloc(HomeInitial()),
            child: const Home(),
          ),
      ROUTE_LOGIN: (context) => BlocProvider(
            create: (context) => LoginBloc(LoginStateInitial()),
            child: Login(),
          ),
      ROUTE_CUSTOMER_QUERY: (context) => BlocProvider(
            create: (context) =>
                CustomerQueryBloc(CustomerQueryStateInitial())..add(CustomerQueryEventFetchAll()),
            child: const CustomerQuery(),
          ),
    };
