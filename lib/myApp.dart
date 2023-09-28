import 'package:agendamentos/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:agendamentos/pages/sign_in/sign_in.dart';
import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SkedolTheme skedolTheme = SkedolTheme();

    return MaterialApp(
      title: 'Skedol',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('pt', 'BR'), // Portuguese
      ],
      home: BlocProvider<SignInBloc>(
        create: (_) => SignInBloc(SignInStateInitial())..add(SignInEventAuthenticated()),
        child: const SignIn(),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: skedolTheme.primaryWhiteColor,
        focusColor: skedolTheme.primaryWhiteColor,
        scaffoldBackgroundColor: skedolTheme.getWhiteScaffoldBackgroundColor(),
        floatingActionButtonTheme: skedolTheme.getWhiteFloatingActionButtonThemeData(),
        inputDecorationTheme: skedolTheme.getWhiteInputDecorationTheme(),
        listTileTheme: skedolTheme.getWhiteListTileTheme(),
        tabBarTheme: skedolTheme.getWhiteTabBarTheme(),
        appBarTheme: skedolTheme.getWhiteAppBarTheme(),
        hintColor: skedolTheme.primaryWhiteColor,
        snackBarTheme: skedolTheme.getWhiteSnackBarThemeData(),
        fontFamily: GoogleFonts.poppins().fontFamily,
        progressIndicatorTheme: skedolTheme.getWhiteProgressIndicatorTheme(),
        textButtonTheme: skedolTheme.getWhiteTextButtonThemeData(),
        highlightColor: Colors.white,
        dialogTheme: skedolTheme.getWhiteDialogTheme(),
        elevatedButtonTheme: skedolTheme.getWhiteElevatedButtonTheme(),
        iconTheme: skedolTheme.getWhiteIconTheme(),
        datePickerTheme: skedolTheme.getWhiteDatePickerTheme(),
        useMaterial3: true,
      ),
      // Por enquanto meu app não terá modo escuro, vou pensar numa identifidade visual posteriormente...
      /*darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryDarkColor,
        focusColor: primaryDarkColor,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryDarkColor,
          splashColor: primaryDarkColor,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: primaryDarkColor,
        ),
        appBarTheme: AppBarTheme(
          elevation: 1,
          shadowColor: Colors.black26,
          titleTextStyle: GoogleFonts.roboto(
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
        fontFamily: GoogleFonts
            .nunitoSans()
            .fontFamily,
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
            fontSize: 14,
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
        datePickerTheme: const DatePickerThemeData(
          headerBackgroundColor: primaryDarkColor,
        ),
      ),*/
      onGenerateRoute: (settings) => appRoutes(settings),
    );
  }
}

class SkedolTheme {
  static const _primaryWhiteColor = Colors.teal;
  static const _primaryDarkColor = Colors.pink;

  get primaryWhiteColor => _primaryWhiteColor;

  get primaryDarkColor => _primaryDarkColor;

  Color? getWhiteScaffoldBackgroundColor() {
    return Colors.white;
  }

  FloatingActionButtonThemeData? getWhiteFloatingActionButtonThemeData() {
    return const FloatingActionButtonThemeData(
      backgroundColor: _primaryWhiteColor,
      splashColor: _primaryDarkColor,
    );
  }

  InputDecorationTheme? getWhiteInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF6F3F3),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(width: 4, color: _primaryWhiteColor),
        borderRadius: BorderRadius.circular(12),
      ),
      suffixIconColor: Colors.black12,
    );
  }

  TabBarTheme getWhiteTabBarTheme() {
    return const TabBarTheme(
      labelColor: _primaryWhiteColor,
      unselectedLabelColor: Colors.black26,
      labelPadding: EdgeInsets.all(16),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Colors.black12,
        ),
      ),
    );
  }

  ListTileThemeData getWhiteListTileTheme() {
    return const ListTileThemeData(
      iconColor: Colors.black45,
      titleTextStyle: TextStyle(fontSize: 14.0, color: Colors.black45)
    );
  }

  AppBarTheme getWhiteAppBarTheme() {
    return AppBarTheme(
      color: Colors.white,
      elevation: 1,
      titleTextStyle: GoogleFonts.poppins(color: Colors.black45, fontWeight: FontWeight.w600),
      iconTheme: const IconThemeData(color: Colors.black54),
    );
  }

  SnackBarThemeData getWhiteSnackBarThemeData() {
    return SnackBarThemeData(
      backgroundColor: primaryWhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    );
  }

  DatePickerThemeData getWhiteDatePickerTheme() {
    return DatePickerThemeData(
      headerBackgroundColor: primaryWhiteColor,
    );
  }

  IconThemeData getWhiteIconTheme() {
    return IconThemeData(color: primaryWhiteColor);
  }

  ProgressIndicatorThemeData getWhiteProgressIndicatorTheme() {
    return ProgressIndicatorThemeData(
      color: primaryDarkColor,
      circularTrackColor: primaryWhiteColor,
    );
  }

  TextButtonThemeData getWhiteTextButtonThemeData() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  DialogTheme getWhiteDialogTheme() {
    return DialogTheme(
      elevation: 8,
      titleTextStyle: const TextStyle(
        fontSize: 14,
        color: _primaryWhiteColor,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: const TextStyle(fontSize: 14, color: _primaryWhiteColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: primaryWhiteColor,
    );
  }

  ElevatedButtonThemeData getWhiteElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryWhiteColor,
      ),
    );
  }
}
