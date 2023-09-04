import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/repository/api/firebase_repository.dart';
import 'package:agendamentos/repository/api/global_repository.dart';
import 'package:agendamentos/widgets/sf_calendar_schedules/model/schedules_model.dart';

class ScheduleRepository extends FirebaseRepository implements GlobalRepository {
  ScheduleRepository._() : super(controller_name: "schedule");
  static final instance = ScheduleRepository._();

  @override
  Future<Map> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List> findAll() async {
    List<ScheduleModule> schedules = [];
    try {
      var response = await dio.get(apiURL);
      for (var data in response.data) {
        Schedule schedule = Schedule.fromJson(data);
        ScheduleModule calendarWidgetSchedule = ScheduleModule(schedule);
        schedules.add(calendarWidgetSchedule);
      }
    } catch (e) {
      throw Exception('Falha na busca pelos agendamentos: ${e.toString()}');
    }
    return schedules;
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

