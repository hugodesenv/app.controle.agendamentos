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
    var response = await dio.get(apiURL);
    print("*** response:");
    print(response.data);
    // TODO: implement findAll
    throw UnimplementedError();
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
