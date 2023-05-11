import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  Future<bool> isAuthenticated() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<bool> signOut() async {
    await FirebaseAuth.instance.signOut();
    bool isAuth = await isAuthenticated();
    return isAuth == false;
  }
}
