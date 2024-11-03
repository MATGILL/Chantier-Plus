import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/core/usecase/usecase.dart';
import 'package:chantier_plus/data/models/auth/login_user.dart';
import 'package:chantier_plus/domain/repository/auth/auth_repository.dart';
import 'package:chantier_plus/service_locator.dart';

class LoginUsecase extends UseCase<ServiceResult<String>, LoginUser> {
  @override
  Future<ServiceResult<String>> call({LoginUser? params}) async {
    return serviceLocator<AuthRepository>().login(params!);
  }
}
