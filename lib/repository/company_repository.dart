import 'package:agendamentos/interface/crud_interface.dart';
import 'package:agendamentos/repository/firebase_repository.dart';

class CompanyRepository extends FirebaseRepository implements CrudInterface {
  CompanyRepository._() : super(collection: 'company');

  static final instance = CompanyRepository._();

  Future<Map<String, dynamic>?> fetchById(String id) async {
    var companyMap = (await getFireCloud.doc(id).get()).data();
    companyMap?['id'] = id;
    return companyMap;
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List> fetchAll() {
    // TODO: implement fetchData
    throw UnimplementedError();
  }

  @override
  Future<String> save(data) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
