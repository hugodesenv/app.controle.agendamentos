import 'package:agendamentos/repository/schedule_repository.dart';
import 'package:flutter/material.dart';
import '../models/account.dart';
import '../pages/schedules/calendar/model/schedules_model.dart';
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
    accountConnected = await PreferencesUtil.getPrefsCurrentUser();
  }

  // procedimento para sair do aplicativo
  Future<bool> logOut() async {
    UserRepository repository = UserRepository.instance;
    bool res = await repository.signOut();
    return res;
  }

  // busca todos os agendamentos na api
  void findAll() async {
    ScheduleRepository repository = ScheduleRepository.instance;
    Map res = await repository.findAll();

    schedules.clear();
    schedules.addAll(res['schedules']);

    notifyListeners();
  }
}
