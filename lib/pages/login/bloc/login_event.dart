import 'package:agendamentos/repository/enums/en_login_modal.dart';

abstract class LoginEvent {}

class LoginEventVerifyAuthentication extends LoginEvent {}

class LoginEventSubmitted extends LoginEvent {
  String _email = '';
  String _password = '';

  LoginEventSubmitted({required email, required password}) {
    _email = email;
    _password = password;
  }

  String get password => _password;

  String get email => _email;
}

class LoginEventShowModal extends LoginEvent {
  final EnModalLogin _enModal;

  LoginEventShowModal({required EnModalLogin enModal}) : _enModal = enModal;

  EnModalLogin get enModal => _enModal;
}

class LoginEventResetPassword extends LoginEvent {
  String _email;

  LoginEventResetPassword({required String email}) : _email = email.trim();

  String get email => _email;

  bool get isEmailValid => _email.isNotEmpty;
}
