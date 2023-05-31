import 'package:agendamentos/model/arguments/args_customer_info.dart';
import 'package:agendamentos/model/arguments/args_customer_new.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_bloc.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_event.dart';
import 'package:agendamentos/pages/customer/import/bloc/customer_import_state.dart';
import 'package:agendamentos/pages/customer/import/customer_import.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/pages/customer/info/customer_info.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_bloc.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/pages/customer/new/customer_new.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/pages/customer/query/customer_query.dart';
import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/pages/item/query/item_query.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:agendamentos/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'assets/routesConstants.dart';
import 'pages/home/home.dart';

appRoutes(RouteSettings settings) {
  if (settings.name == routeHome) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => HomeBloc(HomeInitial()),
          child: const Home(),
        );
      },
    );
  }

  if (settings.name == routeLogin) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
          child: const SignIn(),
        );
      },
    );
  }

  if (settings.name == routeCustomerQuery) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => CustomerQueryBloc(CustomerQueryStateLoading(true))..add(CustomerQueryEventFetchAll()),
          child: CustomerQuery(),
        );
      },
    );
  }

  if (settings.name == routeCustomerNew) {
    var arguments = settings.arguments as ArgsCustomerNew;
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => CustomerNewBloc(CustomerNewStateInitial())
            ..add(
              CustomerNewEventInitial(customer: arguments.customer),
            ),
          child: CustomerNew(arguments: arguments),
        );
      },
    );
  }

  if (settings.name == routeCustomerImport) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => CustomerImportBloc(CustomerImportStateInitial())..add(CustomerImportEventFetchAll()),
          child: const CustomerImport(),
        );
      },
    );
  }

  if (settings.name == routeCustomerInfo) {
    var args = settings.arguments as ArgsCustomerInfo;
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => CustomerInfoBloc(CustomerInfoStateInitial())..add(CustomerInfoEventInitial(args.customer)),
        child: CustomerInfo(argument: args),
      ),
    );
  }

  if (settings.name == routeItemQuery) {
    return MaterialPageRoute(
      builder: (_) => const ItemQuery(),
    );
  }
}
