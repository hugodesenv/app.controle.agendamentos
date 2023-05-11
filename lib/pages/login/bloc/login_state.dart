import '../../../repository/enums/en_login_modal.dart';

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

class LoginStateSplash extends LoginState {}

class LoginStateShowModal extends LoginState {
  final EnModalLogin _enModal;

  LoginStateShowModal(this._enModal);

  EnModalLogin get enModal => _enModal;
}
