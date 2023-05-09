abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  String _message = '';

  LoginFailure({required message}) {
    _message = message;
  }

  String get message => _message;
}

class LoginLoading extends LoginState {}
