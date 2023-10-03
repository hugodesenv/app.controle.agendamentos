import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/models/employee.dart';
import 'package:agendamentos/repository/api/firebase_repository.dart';
import 'package:agendamentos/utils/preferences_util.dart';

import 'global_repository.dart';

class EmployeeRepository extends FirebaseRepository implements GlobalRepository {
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

    Account currentUser = await PreferencesUtil.getPrefsCurrentUser();
    Map filter = {"active": true};
    var response = await dio.get('$apiURL/${currentUser.company.id}', data: filter);

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
