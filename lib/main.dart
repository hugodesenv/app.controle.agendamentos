import 'package:agendamentos/myApp.dart';
import 'package:agendamentos/features/agenda/provider/agenda_provider.dart';
import 'package:agendamentos/auth_provider.dart';
import 'package:agendamentos/features/home/home_provider.dart';
import 'package:agendamentos/features/acesso/provider/login_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //SystemChrome.setPreferredOrientations([
  //  DeviceOrientation.portraitUp,
  //  DeviceOrientation.portraitDown,
  //]).then((value) => runApp(const MyApp()));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider<AgendaProvider>(
          create: (_) => AgendaProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
