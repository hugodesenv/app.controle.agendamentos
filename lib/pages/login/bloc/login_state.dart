abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateSuccess extends LoginState {}

class LoginStateFailure extends LoginState {
  String _message = '';

  LoginStateFailure({required message}) {
    _message = message;
  }

  String get message => _message;
}

class LoginStateLoading extends LoginState {}
