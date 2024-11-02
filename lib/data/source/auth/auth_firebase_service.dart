import 'package:chantier_plus/data/models/auth/create_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService {
  Future<void> login() {
    throw UnimplementedError();
  }

  Future<void> signUp(CreateUser user) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
    } on FirebaseAuthException catch (e) {}
  }
}
