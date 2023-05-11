import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  UserRepository._();

  static final instance = UserRepository._();

  Future<bool> isAuthenticated() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<bool> signOut() async {
    await FirebaseAuth.instance.signOut();
    bool isAuth = await isAuthenticated();
    return isAuth == false;
  }

  Future<void> signInEmailPassword(String pemail, String ppassword) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: pemail, password: ppassword);
  }

  Future resetEmailPassword(String pemail) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: pemail);
  }
}
