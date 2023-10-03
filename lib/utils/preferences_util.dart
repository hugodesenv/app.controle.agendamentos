import 'dart:convert';

import 'package:agendamentos/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SHARED_PREFERENCES_USER_SESSION = 'session';

class PreferencesUtil {
  static Future<Account> getPrefsCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(SHARED_PREFERENCES_USER_SESSION);
    dynamic toJson = jsonDecode(data ?? '');
    return Account.fromMap(toJson);
  }
}
