import 'package:agendamentos/model/login.dart';
import 'package:agendamentos/repository/api/company_repository.dart';
import 'package:agendamentos/repository/api/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository extends FirebaseRepository {
  UserRepository._() : super(collection: 'user');

  /// retrieve logged user
  Login _currentLogin = Login.empty();

  static final instance = UserRepository._();

  Login get currentLogin => _currentLogin;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> signInEmailPassword(String pemail, String ppassword) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: pemail, password: ppassword);
  }

  Future resetEmailPassword(String pemail) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: pemail);
  }

  Future<void> startSession(String id) async {
    var dataLogin = await getFireCloud.doc(id).get();
    var mapLogin = dataLogin.data();

    if (mapLogin!.isNotEmpty) {
      // get company
      var companyId = mapLogin['uuid_company'];
      var companyRepository = CompanyRepository.instance;
      var mapCompany = await companyRepository.fetchById(companyId);

      // to model
      mapLogin['id'] = dataLogin.id;
      mapLogin['company'] = mapCompany;
      _currentLogin = Login.fromMap(mapLogin);
    }
  }
}
