import 'package:agendamentos/models/usuario.dart';
import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:agendamentos/utils/preferences_util.dart';

class EmployeeRepository extends FirebaseRepository implements CrudRepository {
  EmployeeRepository._() : super(controller_name: 'employee');

  static final instance = EmployeeRepository._();

  @override
  Future<Map> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Map> findAll() async {
    List<Employee> employees = [];

    var usuarioAtual = await PreferencesUtil.usuarioAtual();
    Map filter = {"active": true};
    var response =
        await dio.get('$apiURL/${usuarioAtual.empresa.id}', data: filter);

    for (var data in response.data) {
      Employee employee = Employee.fromJson(data);
      employees.add(employee);
    }

    return {"employee": employees};
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
