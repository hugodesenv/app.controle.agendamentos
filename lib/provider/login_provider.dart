import 'dart:async';
import 'package:flutter/material.dart';
import '../models/account.dart';
import '../repository/user_repository.dart';

class LoginProvider extends ChangeNotifier {
  bool _loading = false;
  bool _resettingPassword = false;

  bool get loading => _loading;
  bool get resettingPassword => _resettingPassword;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set resettingPassword(bool value) {
    _resettingPassword = value;
    notifyListeners();
  }

  /// realiza o login no aplicativo
  Future<String> doLogin(String user, String password) async {
    if (user.trim().isEmpty) {
      return 'Usuário inválido';
    }

    if (password.trim().isEmpty) {
      return 'Senha inválida!';
    }

    loading = true;
    try {
      Account res = await UserRepository.instance.signIn(user, password);
      if (res.username.isEmpty) {
        return 'Usuário ou senha incorretos!';
      }
    } finally {
      loading = false;
    }

    return '';
  }

  ///encaminha o e-mail para redefinição de senha
  Future<Map> resetPassword(String email) async {
    resettingPassword = true;
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
      resettingPassword = false;
    }
  }
}
