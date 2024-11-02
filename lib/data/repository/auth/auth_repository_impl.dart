import 'package:chantier_plus/data/models/auth/create_user.dart';
import 'package:chantier_plus/data/source/auth/auth_firebase_service.dart';
import 'package:chantier_plus/domain/repository/auth/auth_repository.dart';
import 'package:chantier_plus/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(CreateUser user) async {
    serviceLocator<AuthFirebaseService>().signUp(user);
  }
}
