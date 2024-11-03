import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/auth/data/source/auth_firebase_service.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/auth/domain/repository/auth_repository.dart';
import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/features/auth/mapper/user_mapper.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<ServiceResult<String>> login(UserEntity user, String password) async {
    if (user.email == null) {
      return ServiceResult(error: "email can't be null.");
    } else if (password.isEmpty) {
      return ServiceResult(error: "password can't be Empty.");
    }
    var loginUser = UserMapper.toLoginDto(user, password);
    return await serviceLocator<AuthFirebaseService>().login(loginUser);
  }

  @override
  Future<ServiceResult<String>> signUp(UserEntity user, String password) async {
    if (user.email == null) {
      return ServiceResult(error: "email can't be null.");
    } else if (user.fullName == null) {
      return ServiceResult(error: "full name can't be null.");
    } else if (password.isEmpty) {
      return ServiceResult(error: "password can't be Empty.");
    }
    var createUser = UserMapper.toCreateDto(user, password);
    return await serviceLocator<AuthFirebaseService>().signUp(createUser);
  }
}
