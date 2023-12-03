import 'package:agendamentos/repository/agenda_repository.dart';
import 'package:flutter/material.dart';

import '../models/account.dart';
import '../pages/agenda/widget/calendario/model/schedules_model.dart';
import '../repository/user_repository.dart';
import '../utils/preferences_util.dart';

class HomeProvider with ChangeNotifier {
  Account _accountConnected = Account.empty();
  final List<ScheduleModule> _schedules = [];

  Account get accountConnected => _accountConnected;

  set accountConnected(Account value) {
    _accountConnected = value;
    notifyListeners();
  }

  List<ScheduleModule> get schedules => _schedules;

  // mantém armazenado no objeto quem está logado
  Future<void> checkUserLogin() async {
    accountConnected = await PreferencesUtil.currentUser();
  }

  // procedimento para sair do aplicativo
  Future<bool> logOut() async {
    UserRepository repository = UserRepository.instance;
    bool res = await repository.signOut();
    return res;
  }

  void buscarTodos() async {
    var repository = AgendaRepository.instance;
    Map res = await repository.findAll();

    schedules.clear();
    schedules.addAll(res['schedules']);

    notifyListeners();
  }
}
