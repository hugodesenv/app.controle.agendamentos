import 'package:agendamentos/enum/agendamento_situacao_enum.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:intl/intl.dart';
import '../models/schedule.dart';

class AgendaRepository extends FirebaseRepository implements CrudRepository {
  AgendaRepository._() : super(controller_name: "schedule");
  static final instance = AgendaRepository._();

  @override
  Future<Map> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<dynamic> findAll() async {
    List<Schedule> schedules = [];
    //Map<String, dynamic> totals = {};
    try {
      var response = await dio.get(apiURL);
      for (var data in response.data) {
        Schedule schedule = Schedule.fromJson(data);

        /*_handleTotal(
          totals,
          schedule.scheduleDate,
          schedule.situation.text(),
          schedule.totalPrice,
        );*/

        //ScheduleModule calendarWidgetSchedule = ScheduleModule(
        //  schedule: schedule,
        //  eventDate: schedule.scheduleDate,
        //);

        schedules.add(schedule);
      }
    } catch (e) {
      throw Exception('Falha na busca pelos agendamentos: ${e.toString()}');
    }
    return schedules;
  }

  static keyTotalizador(DateTime data) => DateFormat.yMMMMd().format(data);

  /*_handleTotal(Map total, DateTime data, String situation, double totalPrice) {
    String key = keyTotalizador(data);

    if (total[key] == null) total[key] = {};
    if (total[key][situation] == null) total[key][situation] = 0;

    total[key][situation] += totalPrice;
  }*/

  @override
  Future<Map> save(data) async {
    Schedule schedule = data as Schedule;
    Map toMap = schedule.toMap();

    var response = await dio.post(apiURL, data: toMap);

    return response.data;
  }

  @override
  Future<Map> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
