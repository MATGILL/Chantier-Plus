import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/auth/domain/repository/auth_repository.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<ServiceResult<String>> login(
      UserEntity loginUser, String password) async {
    return await _authRepository.login(loginUser, password);
  }

  Future<ServiceResult<String>> signUp(
      UserEntity createUser, String password) async {
    return await _authRepository.signUp(createUser, password);
  }
}
