import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/data/models/auth/create_user.dart';
import 'package:chantier_plus/data/models/auth/login_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService {
  Future<ServiceResult<String>> login(LoginUser user) async {
    try {
      // Utiliser FirebaseAuth pour connecter l'utilisateur avec email et mot de passe
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      return ServiceResult<String>(content: "Login was successful");
    } on FirebaseAuthException catch (e) {
      return ServiceResult(error: e.message ?? "An unknown error occurred");
    }
  }

  Future<ServiceResult<String>> signUp(CreateUser user) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      return ServiceResult<String>(content: "Sign up was successFull");
    } on FirebaseAuthException catch (e) {
      return ServiceResult(error: e.toString());
    }
  }
}
