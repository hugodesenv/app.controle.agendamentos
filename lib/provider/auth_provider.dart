import 'package:flutter/material.dart';
import '../models/account.dart';
import '../utils/preferences_util.dart';

class AuthProvider with ChangeNotifier {
  bool _directToHome = false;

  bool get directToHome => _directToHome;

  Future<void> checkUser() async {
    Account account = await PreferencesUtil.getPrefsCurrentUser();
    _directToHome = account.username.isNotEmpty;
    notifyListeners();
  }
}
