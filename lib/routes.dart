import 'package:agendamentos/pages/client/client.dart';

import 'pages/home/home.dart';
import 'pages/login/login.dart';

const ROUTE_HOME = '/home';
const ROUTE_LOGIN = '/login';
const ROUTE_CLIENT = '/client';

appRoutes() => {
      ROUTE_HOME: (context) => const Home(),
      ROUTE_LOGIN: (context) => const Login(),
      ROUTE_CLIENT: (context) => const Client(),
    };
