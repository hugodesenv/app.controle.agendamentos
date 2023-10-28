import 'package:agendamentos/repository/firebase_repository.dart';

class CompanyRepository extends FirebaseRepository implements CrudRepository {
  CompanyRepository._() : super(controller_name: 'company');

  static final instance = CompanyRepository._();

  Future<Map<String, dynamic>?> fetchById(String id) async {
    var companyMap = (await getFireCloud.doc(id).get()).data();
    companyMap?['id'] = id;
    return companyMap;
  }

  @override
  Future<Map> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Map> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Map> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Map> save(data) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
