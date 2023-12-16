import 'package:agendamentos/enum/agendamento_situacao_enum.dart';
import 'package:agendamentos/repository/agenda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/schedule.dart';
import '../../../models/usuario.dart';
import '../../../repository/usuario_repository.dart';
import '../../../utils/preferences_util.dart';

class HomeProvider with ChangeNotifier {
  List<Schedule> agendamentos = [];
  Map<AgendamentoSituacao, double> totalizadores = {};
  Usuario _usuarioConectado = Usuario.empty();
  DateTime? dataSelecionada;

  /// Com a data atual que está selecionada no componente da tela, eu faço o filtro
  /// nos compromissos obtendo os agendamentos desse dia, e gravo nas variaveis de controle
  /// da tela.
  calcularTotalizadores(DateTime? pDataSelecionada) {
    totalizadores.clear();
    dataSelecionada = pDataSelecionada;

    bool filtrarData(Schedule s) => (DateFormat.yMd().format(s.scheduleDate) ==
        DateFormat.yMd().format(dataSelecionada!));

    final listaFiltrada = agendamentos.where((e) => filtrarData(e)).toList();

    for (var e in listaFiltrada) {
      totalizadores[e.situation] =
          ((totalizadores[e.situation] ?? 0.0) + e.totalPrice);
    }

    notifyListeners();
  }

  Future<void> buscaUsuarioLogado() async {
    usuarioContectado = await PreferencesUtil.usuarioAtual();
  }

  Future<bool> deslogar() async {
    var repository = UserRepository.instance;
    return await repository.signOut();
  }

  void buscarTodos() async {
    List<Schedule> compromissos = await AgendaRepository.instance.findAll();

    agendamentos.clear();
    agendamentos.addAll(compromissos);

    calcularTotalizadores(dataSelecionada);
    notifyListeners();
  }

  void excluir(Schedule agendamento) {
    print("** ${agendamento.customer.name}");
  }

  set usuarioContectado(Usuario usuario) {
    _usuarioConectado = usuario;
    notifyListeners();
  }

  Usuario get usuarioContectado => _usuarioConectado;
}
