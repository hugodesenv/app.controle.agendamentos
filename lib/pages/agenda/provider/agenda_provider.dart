import 'package:agendamentos/enum/agendamento_situacao_enum.dart';
import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/models/employee.dart';
import 'package:flutter/foundation.dart';

import '../../../models/schedule.dart';
import '../../../models/schedule_item.dart';
import '../../../repository/agenda_repository.dart';

class AgendaProvider with ChangeNotifier {
  late Schedule _agenda;

  AgendaProvider() {
    _agenda = Schedule.empty();
  }

  Schedule get agenda => _agenda;

  alterarCliente(Customer? pCustomer) {
    _agenda = agenda.copyWith(customer: pCustomer);
  }

  alterarDataHora(DateTime? pDate) {
    _agenda = agenda.copyWith(scheduleDate: pDate);
  }

  alterarProfissional(Employee? pEmployee) {
    _agenda = agenda.copyWith(employee: pEmployee);
  }

  alterarSituacao(AgendamentoSituacao? pSituation) {
    _agenda = agenda.copyWith(situation: pSituation);
  }

  adicionarItem(ScheduleItem currentItem) {
    agenda.saveItem(currentItem);
    //var itemsActives = schedule.filtrarItens(ActionAPI.tDeleted, false);
    //schedule.scheduleItem = itemsActives;
    notifyListeners();
  }

  removerItem(ScheduleItem pItem) {
    agenda.removeItem(pItem);
    //var itemsActives = schedule.filtrarItens(ActionAPI.tDeleted, false);
    //schedule.scheduleItem = itemsActives;
    notifyListeners();
  }

  salvar() async {
    var repository = AgendaRepository.instance;
    var res = await repository.save(agenda);
    print("¨¨¨ agenda_provider: $res");
  }
}
