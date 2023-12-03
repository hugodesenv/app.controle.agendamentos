import 'dart:convert';

import 'package:agendamentos/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static Future<Account> currentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString('session');
    dynamic toJson = jsonDecode(data ?? '');
    return Account.fromMap(toJson);
  }
}
