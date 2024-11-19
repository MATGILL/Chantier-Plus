import 'package:chantier_plus/core/service_locator.dart';
import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/auth/data/source/auth_firebase_service.dart';
import 'package:chantier_plus/features/auth/domain/repository/auth_repository.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/auth/mapper/user_mapper.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<ServiceResult<String>> login(UserEntity user, String password) async {
    if (user.email == null) {
      return ServiceResult(error: "email can't be null.");
    } else if (password.isEmpty) {
      return ServiceResult(error: "password can't be Empty.");
    }
    var loginUser = UserMapper.toLoginDto(user, password);
    return await _authRepository.login(loginUser);
  }

  Future<ServiceResult<String>> signUp(UserEntity user, String password) async {
    if (user.email == null) {
      return ServiceResult(error: "email can't be null.");
    } else if (user.fullName == null) {
      return ServiceResult(error: "full name can't be null.");
    } else if (password.isEmpty) {
      return ServiceResult(error: "password can't be Empty.");
    }
    var createUser = UserMapper.toCreateDto(user, password);
    return await _authRepository.signUp(createUser);
  }

  Future<ServiceResult<String>> getUserRoleById(String userId) async {
    return await serviceLocator<AuthFirebaseService>().getUserRoleById(userId);
  }
}
