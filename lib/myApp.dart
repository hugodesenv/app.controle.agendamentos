import 'package:agendamentos/assets/colorConstantes.dart';
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
    return MaterialApp(
      home: BlocProvider<SignInBloc>(
        create: (_) => SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
        child: const SignIn(),
      ),
      title: 'Skedol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(primaryColor),
        focusColor: Colors.indigoAccent,
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(primaryColor),
          splashColor: Colors.pink,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8F8F8),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 4, color: Color(primaryColor)),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIconColor: const Color(primaryColor),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
          shadowColor: Colors.black26,
          titleTextStyle: GoogleFonts.nunitoSans(
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          iconTheme: const IconThemeData(color: Colors.black54),
        ),
        hintColor: const Color(primaryColor),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.pinkAccent,
          circularTrackColor: Color(primaryColor),
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
          contentTextStyle: const TextStyle(fontSize: 14, color: Color(primaryColor)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: const Color(primaryColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(primaryColor),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pink,
        focusColor: Colors.pinkAccent,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.pink,
          splashColor: Color(primaryColor),
        ),
        appBarTheme: AppBarTheme(
          elevation: 1,
          shadowColor: Colors.black26,
          titleTextStyle: GoogleFonts.nunitoSans(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
          iconTheme: const IconThemeData(color: Colors.white70),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 4, color: Color(primaryColor)),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIconColor: Colors.pinkAccent,
        ),
        //hintColor: const Color(primaryColor),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.pink,
          contentTextStyle: TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
          circularTrackColor: Colors.pink,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        dialogTheme: DialogTheme(
          elevation: 8,
          titleTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          contentTextStyle: const TextStyle(
            fontSize: 14,
            color: Color(primaryColor),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: const Color(primaryColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(primaryColor),
          ),
        ),
      ),
      onGenerateRoute: (settings) => appRoutes(settings),
    );
  }
}
