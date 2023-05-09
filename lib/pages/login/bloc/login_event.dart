abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  String _username = '';
  String _password = '';

  LoginSubmitted({required username, required password}) {
    _username = username;
    _password = password;
  }

  String get password => _password;

  String get username => _username;
}
