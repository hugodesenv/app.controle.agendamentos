import 'dart:async';
import 'package:flutter/material.dart';
import '../models/account.dart';
import '../repository/user_repository.dart';

class LoginProvider with ChangeNotifier {
  bool _loading = false;
  final bool _resetPassword = false;

  bool get loading => _loading;
  bool get resetPassword => _resetPassword;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set resetPassword(bool value) {
    resetPassword = value;
    notifyListeners();
  }

  Future<String> tryLogin(String pUser, String pPassword) async {
    if (pUser.trim().isEmpty) {
      return 'Usuário inválido';
    }

    if (pPassword.trim().isEmpty) {
      return 'Senha inválida!';
    }

    loading = true;
    try {
      Account res = await UserRepository.instance.signIn(pUser, pPassword);
      if (res.username.isEmpty) {
        return 'Usuário ou senha incorretos!';
      }
    } finally {
      loading = false;
    }

    return '';
  }

  ///encaminha o e-mail para redefinição de senha
  Future<Map> sendResetUserEmail(String email) async {
    resetPassword = true;
    try {
      UserRepository repository = UserRepository.instance;
      try {
        await repository.resetEmailPassword(email);
        return {
          'error': false,
          'message': 'E-mail encaminhado!',
        };
      } catch (e) {
        return {
          'error': true,
          'message': 'Falha no envio do e-mail, verifique as credenciais.',
        };
      }
    } finally {
      resetPassword = false;
    }
  }
}
