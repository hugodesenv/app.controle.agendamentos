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
        create: (_) =>
            SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
        child: const SignIn(),
      ),
      title: 'Skedol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
        focusColor: Colors.indigoAccent,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8F8F8),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 4, color: mainColor),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIconColor: mainColor,
        ),
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
        hintColor: mainColor,
        snackBarTheme: const SnackBarThemeData(backgroundColor: Colors.indigo),
        fontFamily: GoogleFonts.sora().fontFamily,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.pinkAccent,
          circularTrackColor: mainColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        highlightColor: Colors.white,
        dialogTheme: DialogTheme(
          elevation: 8,
          titleTextStyle: const TextStyle(
            fontSize: 16,
            color: Colors.indigo,
            fontWeight: FontWeight.w600,
          ),
          contentTextStyle: TextStyle(fontSize: 14, color: mainColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: mainColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
          ),
        ),
      ),
      onGenerateRoute: (settings) => appRoutes(settings),
    );
  }
}
