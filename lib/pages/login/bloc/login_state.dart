abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFail extends LoginState {
  String? _message;

  LoginFail({required message}) {
    _message = message ?? "";
  }

  String get message => _message!;
}

class LoginLoading extends LoginState {}
