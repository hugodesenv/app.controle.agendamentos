import 'dart:convert';
import 'package:agendamentos/models/usuario.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository extends FirebaseRepository {
  UserRepository._() : super(controller_name: 'account');
  static final instance = UserRepository._();

  Future<bool> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool prefsClean = await preferences.clear();
    return prefsClean;
  }

  Future<Usuario> signIn(String pUsername, String pPassword) async {
    final body = {'username': pUsername, 'password': pPassword};
    final response = await dio.post('$apiURL/login', data: body);

    final account = Usuario.fromMap(response.data);
    await _saveSession(account);

    return account;
  }

  Future<void> _saveSession(Usuario account) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('session', jsonEncode(account.toMap()));
  }

  Future resetEmailPassword(String pemail) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: pemail);
  }
}
