import 'dart:convert';

import 'package:agendamentos/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static Future<Usuario> usuarioAtual() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString('session');
    dynamic toJson = jsonDecode(data ?? '');
    return Usuario.fromMap(toJson);
  }
}
