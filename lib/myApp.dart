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
    const primaryWhiteColor = Colors.indigo;
    const primaryDarkColor = Colors.pink;

    return MaterialApp(
      home: BlocProvider<SignInBloc>(
        create: (_) => SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
        child: const SignIn(),
      ),
      title: 'Skedol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryWhiteColor,
        focusColor: primaryWhiteColor,
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryWhiteColor,
          splashColor: primaryDarkColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8F8F8),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 4, color: primaryWhiteColor),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIconColor: primaryWhiteColor,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: primaryWhiteColor,
          unselectedLabelColor: Colors.black26,
          labelPadding: EdgeInsets.all(16),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
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
        hintColor: primaryWhiteColor,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: primaryWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: primaryDarkColor,
          circularTrackColor: primaryWhiteColor,
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
            color: primaryWhiteColor,
            fontWeight: FontWeight.w600,
          ),
          contentTextStyle: const TextStyle(fontSize: 14, color: primaryWhiteColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: primaryWhiteColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryWhiteColor,
          ),
        ),
        iconTheme: const IconThemeData(color: primaryWhiteColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryDarkColor,
        focusColor: primaryDarkColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryDarkColor,
          splashColor: primaryDarkColor,
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
        tabBarTheme: const TabBarTheme(
          labelColor: primaryDarkColor,
          unselectedLabelColor: Colors.black26,
          labelPadding: EdgeInsets.all(16),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 4, color: primaryDarkColor),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIconColor: primaryDarkColor,
        ),
        //hintColor: const Color(primaryColor),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: primaryDarkColor,
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
          circularTrackColor: primaryDarkColor,
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
            color: Colors.black,
          ),
          contentTextStyle: const TextStyle(
            fontSize: 14,
            color: primaryDarkColor,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: primaryDarkColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryDarkColor,
          ),
        ),
        iconTheme: const IconThemeData(color: primaryDarkColor),
      ),
      onGenerateRoute: (settings) => appRoutes(settings),
    );
  }
}
