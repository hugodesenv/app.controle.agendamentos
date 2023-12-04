import 'package:agendamentos/repository/agenda_repository.dart';
import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../pages/agenda/widget/calendario/model/schedules_model.dart';
import '../repository/usuario_repository.dart';
import '../utils/preferences_util.dart';

class HomeProvider with ChangeNotifier {
  // armazeno os dados dos compromissos que trouxeram na busca
  final List<ScheduleModule> _agendamentos = [];
  // armazeno o totalizador de todos os dias que trouxe na busca
  final Map _totalizadores = {};
  // armazeno o totalizador da data selecionada no calendario
  Map _totalizadorDoDiaSelecionado = {};
  // armazeno o usuario que está logado no aplicativo
  Usuario _usuarioConectado = Usuario.empty();

  Usuario get usuarioContectado => _usuarioConectado;

  Future<void> buscaUsuarioLogado() async {
    usuarioContectado = await PreferencesUtil.usuarioAtual();
  }

  Future<bool> deslogar() async {
    var repository = UserRepository.instance;
    return await repository.signOut();
  }

  void buscarTodos() async {
    var repository = AgendaRepository.instance;
    Map res = await repository.findAll();

    agendamentos.clear();
    agendamentos.addAll(res['agendamentos']);

    _totalizadores.clear;
    _totalizadores.addAll(res['totais']);

    notifyListeners();
  }

  void alternouData(DateTime dataSelecionada) {
    String key = AgendaRepository.keyTotalizador(dataSelecionada);
    totalizadorAtual = _totalizadores[key];
  }

  set usuarioContectado(Usuario usuario) {
    _usuarioConectado = usuario;
    notifyListeners();
  }

  Map get totalizadorDoDiaSelecionado => _totalizadorDoDiaSelecionado;

  set totalizadorAtual(Map? dados) {
    _totalizadorDoDiaSelecionado = {};

    if (dados != null) {
      print(dados);
      _totalizadorDoDiaSelecionado.addAll(dados);
    }

    print(_totalizadorDoDiaSelecionado);

    notifyListeners();
  }

  List<ScheduleModule> get agendamentos => _agendamentos;
}
