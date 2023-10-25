import 'package:agendamentos/repository/api/firebase_repository.dart';
import '../../utils/interface/crud_interface.dart';

class CompanyRepository extends FirebaseRepository implements CrudInterface {
  CompanyRepository._() : super(controller_name: 'company');

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
  Future<String> save(data) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<void> fetchAllStream(Function(List p1) onDataProcessed) {
    // TODO: implement fetchAllStream
    throw UnimplementedError();
  }
}
