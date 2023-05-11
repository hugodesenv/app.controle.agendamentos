import 'package:agendamentos/repository/enums/en_login_loading.dart';

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

class LoginStateLoading extends LoginState {
  final EnLoginLoading _typeLoading;

  LoginStateLoading(this._typeLoading);

  EnLoginLoading get typeLoading => _typeLoading;
}

class LoginStateSplash extends LoginState {}

class LoginStateShowModal extends LoginState {
  final EnModalLogin _enModal;

  LoginStateShowModal(this._enModal);

  EnModalLogin get enModal => _enModal;
}

class LoginStateSuccessResetEmail extends LoginState {
  String _message = '';

  LoginStateSuccessResetEmail({required message}) : _message = message;

  String get message => _message;
}

class LoginStateFailureResetEmail extends LoginState {
  String _message = '';

  LoginStateFailureResetEmail({required String message}) : _message = message;

  String get message => _message;
}
