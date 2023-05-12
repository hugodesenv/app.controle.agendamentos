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
