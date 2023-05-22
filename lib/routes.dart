import 'package:agendamentos/main.dart';
import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_bloc.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_event.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_state.dart';
import 'package:agendamentos/pages/customer/import/customer_import.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_bloc.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/pages/customer/new/customer_new.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/pages/customer/query/customer_query.dart';
import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:agendamentos/pages/sign_in/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home/home.dart';

const ROUTE_HOME = '/home';
const ROUTE_LOGIN = '/login';
const ROUTE_CUSTOMER_QUERY = '/customer_query';
const ROUTE_CUSTOMER_NEW = '/customer_new';
const ROUTE_CUSTOMER_IMPORT = '/customer_import';

appRoutes(RouteSettings settings) {
  if (settings.name == ROUTE_HOME) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => HomeBloc(HomeInitial()),
          child: const Home(),
        );
      },
    );
  }

  if (settings.name == ROUTE_LOGIN) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
          child: const SignIn(),
        );
      },
    );
  }

  if (settings.name == ROUTE_CUSTOMER_QUERY) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => getIt<CustomerQueryBloc>(),
          //CustomerQueryBloc(CustomerQueryStateLoading(true))..add(CustomerQueryEventFetchAll()),
          child: const CustomerQuery(),
        );
      },
    );
  }

  if (settings.name == ROUTE_CUSTOMER_NEW) {
    var callback = settings.arguments as Function(Customer customer);
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => CustomerNewBloc(CustomerNewStateInitial()),
          child: CustomerNew(onSaved: callback),
        );
      },
    );
  }

  if (settings.name == ROUTE_CUSTOMER_IMPORT) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) =>
              CustomerImportBloc(CustomerImportStateInitial())..add(CustomerImportEventFetchAll()),
          child: const CustomerImport(),
        );
      },
    );
  }
}
