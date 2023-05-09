import 'package:agendamentos/pages/login/bloc/login_bloc.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:agendamentos/pages/login/login.dart';
import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.indigo;
    return MaterialApp(
      home: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(LoginInitial()),
        child: Login(),
      ),
      title: 'Skedol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
        focusColor: Colors.indigoAccent,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 1,
          shadowColor: Colors.black12,
          titleTextStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: Colors.black54),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.indigo, circularTrackColor: Colors.indigoAccent),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            foregroundColor: mainColor,
          ),
        ),
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: mainColor)),
      ),
      routes: appRoutes(),
    );
  }
}
