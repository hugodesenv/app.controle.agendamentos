import 'package:agendamentos/models/login.dart';

abstract class SignInState {}

class SignInStateInitial extends SignInState {}

class SignInStateLoading extends SignInState {}

class SignInStateSuccess extends SignInState {}

class SignInStateGoToHome extends SignInState {}

class SignInStateFailure extends SignInState {
  String _message;

  SignInStateFailure(this._message);

  String get message => _message;
}

class SignInStateWaitingEmailReset extends SignInState {}

class SignInStateResetPassword extends SignInState {
  bool _emailSent;
  String _message;

  SignInStateResetPassword({required bool emailSent, required String message})
      : _emailSent = emailSent,
        _message = message;

  bool get emailSent => _emailSent;

  String get message => _message;
}
