import 'package:agendamentos/pages/client/client.dart';
import 'package:agendamentos/pages/home/bloc/home_bloc.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/pages/login/bloc/login_bloc.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home/home.dart';
import 'pages/login/login.dart';

const ROUTE_HOME = '/home';
const ROUTE_LOGIN = '/login';
const ROUTE_CLIENT = '/client';

appRoutes() => {
      ROUTE_HOME: (context) =>
          BlocProvider(create: (context) => HomeBloc(HomeInitial()), child: const Home()),
      ROUTE_LOGIN: (context) =>
          BlocProvider(create: (context) => LoginBloc(LoginInitial()), child: const Login()),
      ROUTE_CLIENT: (context) => const Client(),
    };
