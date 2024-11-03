import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/data/models/auth/create_user.dart';
import 'package:chantier_plus/data/models/auth/login_user.dart';
import 'package:chantier_plus/data/source/auth/auth_firebase_service.dart';
import 'package:chantier_plus/domain/repository/auth/auth_repository.dart';
import 'package:chantier_plus/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<ServiceResult<String>> login(LoginUser user) async {
    return await serviceLocator<AuthFirebaseService>().login(user);
  }

  @override
  Future<ServiceResult<String>> signUp(CreateUser user) async {
    return await serviceLocator<AuthFirebaseService>().signUp(user);
  }
}
