import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/pages/customer/query/customer_query.dart';
import 'package:agendamentos/pages/customer/register/import/bloc/customer_register_import_bloc.dart';
import 'package:agendamentos/pages/customer/register/import/bloc/customer_register_import_state.dart';
import 'package:agendamentos/pages/customer/register/import/customer_register_import.dart';
import 'package:agendamentos/pages/customer/register/new/bloc/customer_register_bloc.dart';
import 'package:agendamentos/pages/customer/register/new/bloc/customer_register_state.dart';
import 'package:agendamentos/pages/customer/register/new/customer_register_new.dart';
import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:agendamentos/pages/sign_in/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home/home.dart';

const ROUTE_HOME = '/home';
const ROUTE_LOGIN = '/login';
const ROUTE_CUSTOMER_QUERY = '/customer_query';
const ROUTE_CUSTOMER_NEW = '/customer_new';
const ROUTE_CUSTOMER_IMPORT = '/customer_import';

appRoutes() => {
      ROUTE_HOME: (_) => BlocProvider(
            create: (_) => HomeBloc(HomeInitial()),
            child: const Home(),
          ),
      ROUTE_LOGIN: (_) => BlocProvider(
            create: (_) => SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
            child: const SignIn(),
          ),
      ROUTE_CUSTOMER_QUERY: (_) => BlocProvider(
            create: (_) => CustomerQueryBloc(CustomerQueryStateInitial())..add(CustomerQueryEventFetchAll()),
            child: const CustomerQuery(),
          ),
      ROUTE_CUSTOMER_NEW: (_) => BlocProvider(
            create: (_) => CustomerRegisterBloc(CustomerRegisterStateInitial()),
            child: const CustomerRegisterNew(),
          ),
      ROUTE_CUSTOMER_IMPORT: (_) => BlocProvider(
            create: (context) => CustomerRegisterImportBloc(CustomerRegisterImportInitial()),
            child: const CustomerRegisterImport(),
          ),
    };
