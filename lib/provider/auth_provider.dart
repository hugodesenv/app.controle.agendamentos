import 'package:flutter/material.dart';

import '../utils/preferences_util.dart';

class AuthProvider with ChangeNotifier {
  bool _directToHome = false;

  bool get directToHome => _directToHome;

  Future<void> checkUser() async {
    var usuario = await PreferencesUtil.usuarioAtual();
    _directToHome = usuario.usuario.isNotEmpty;
    notifyListeners();
  }
}
