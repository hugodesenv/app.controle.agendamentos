import 'package:agendamentos/pages/client_search/bloc/client_search_bloc.dart';
import 'package:agendamentos/pages/client_search/bloc/client_search_state.dart';
import 'package:agendamentos/pages/client_search/client_search.dart';
import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/pages/login/bloc/login_bloc.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home/home.dart';
import 'pages/login/login.dart';

const ROUTE_HOME = '/home';
const ROUTE_LOGIN = '/login';
const ROUTE_CLIENT_SEARCH = '/client_search';

appRoutes() => {
      ROUTE_HOME: (context) =>
          BlocProvider(create: (context) => HomeBloc(HomeInitial()), child: const Home()),
      ROUTE_LOGIN: (context) =>
          BlocProvider(create: (context) => LoginBloc(LoginInitial()), child: Login()),
      ROUTE_CLIENT_SEARCH: (context) => BlocProvider(
          create: (context) => ClientSearchBloc(ClientSearchFetchAll()),
          child: const ClientSearch()),
    };
