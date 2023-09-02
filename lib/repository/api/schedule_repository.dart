import 'package:agendamentos/models/schedule.dart';
import 'package:agendamentos/repository/api/firebase_repository.dart';
import 'package:agendamentos/repository/api/global_repository.dart';

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
    List<Schedule> schedules = [];
    try {
      var response = await dio.get(apiURL);
      for(var data in response.data) {
        print("** dentro do for");
        Schedule schedule = Schedule.fromJson(data);
        print("** ids");
        print(schedule.id);
      }
    } catch (e) {
      print("** catch: ${e.toString()}");
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
