import 'package:agendamentos/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:agendamentos/pages/sign_in/sign_in.dart';
import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.indigo;
    return MaterialApp(
      home: BlocProvider<SignInBloc>(
        create: (_) => SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
        child: const SignIn(),
      ),
      title: 'Skedol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
        focusColor: Colors.indigoAccent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
          shadowColor: Colors.black26,
          titleTextStyle: GoogleFonts.sora(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        textTheme: GoogleFonts.soraTextTheme(),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.orange, circularTrackColor: mainColor),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            foregroundColor: mainColor,
          ),
        ),
        highlightColor: Colors.white,
        dialogTheme: DialogTheme(
          elevation: 8,
          titleTextStyle: const TextStyle(fontSize: 16, color: Colors.indigo, fontWeight: FontWeight.w600),
          contentTextStyle: TextStyle(fontSize: 14, color: mainColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: mainColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: mainColor)),
      ),
      routes: appRoutes(),
    );
  }
}
