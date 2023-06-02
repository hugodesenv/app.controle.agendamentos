import 'package:agendamentos/model/company.dart';
import 'package:agendamentos/model/login.dart';
import 'package:agendamentos/repository/company_repository.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository extends FirebaseRepository {
  UserRepository._() : super(collection: 'user');

  static final instance = UserRepository._();

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

  Future<Login> fetchUserById(String id) async {
    Login loginResult = Login.empty();

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
      loginResult = Login.fromMap(mapLogin);
    }

    return loginResult;
  }
}
