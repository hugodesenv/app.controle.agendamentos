abstract class SignInEvent {}

class SignInEventSubmitted extends SignInEvent {
  String? _username;
  String? _password;

  SignInEventSubmitted({required username, required password}) {
    _username = username;
    _password = password;
  }

  String get password => _password ?? '';

  String get username => _username ?? '';
}

class SignInEventAuthenticated extends SignInEvent {}

class SignInEventSubmittedForgetPassword extends SignInEvent {
  String? _email;

  SignInEventSubmittedForgetPassword(this._email);

  String get email => _email ?? '';
}
