import 'package:agendamentos/repository/firebase_repository.dart';

class CompanyRepository extends FirebaseRepository {
  CompanyRepository._() : super(collection: 'company');

  static final instance = CompanyRepository._();

  Future<Map<String, dynamic>?> fetchById(String id) async {
    var companyMap = (await getFireCloud.doc(id).get()).data();
    companyMap?['id'] = id;
    return companyMap;
  }
}
