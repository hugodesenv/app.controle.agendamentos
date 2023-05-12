abstract class SignInEvent {}

class SignInEventSubmitted extends SignInEvent {
  String? _email;
  String? _password;

  SignInEventSubmitted({required email, required password}) {
    _email = email;
    _password = password;
  }

  String get password => _password ?? '';

  String get email => _email ?? '';
}

class SignInEventAuthenticated extends SignInEvent {}
