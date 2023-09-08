import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/repository/api/firebase_repository.dart';
import 'package:agendamentos/repository/api/global_repository.dart';
import 'package:intl/intl.dart';

import '../../pages/schedules/calendar/model/schedules_model.dart';

class ScheduleRepository extends FirebaseRepository implements GlobalRepository {
  ScheduleRepository._() : super(controller_name: "schedule");
  static final instance = ScheduleRepository._();

  @override
  Future<Map> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Map> findAll() async {
    List<ScheduleModule> schedules = [];
    Map<String, dynamic> totals = {};
    try {
      var response = await dio.get(apiURL);
      for (var data in response.data) {
        Schedule schedule = Schedule.fromJson(data);

        Qual o proximo passo no SKedol?
        Criar a coluna de situacao na tabela "schedule"
        Fazer as tratativas na API para gravar e editar
        Criar um enumerado para melhor organização com essas coisas, pra usar aqui e na tabela Home

        _handleTotal(
          totals,
          schedule.scheduleDate,
          schedule.situation,
          schedule.totalPrice,
        );

        ScheduleModule calendarWidgetSchedule = ScheduleModule(schedule);
        schedules.add(calendarWidgetSchedule);
      }
    } catch (e) {
      throw Exception('Falha na busca pelos agendamentos: ${e.toString()}');
    }
    return {"schedules": schedules, "totals": totals};
  }

  _handleTotal(Map total, DateTime date, String situation, double totalPrice) {
    String key = DateFormat.yMMMMd().format(date);

    if (total[key] == null) total[key] = {};
    if (total[key][situation] == null) total[key][situation] = 0;

    total[key][situation] += totalPrice;
  }

  @override
  Future<Map> save(data) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<Map> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
