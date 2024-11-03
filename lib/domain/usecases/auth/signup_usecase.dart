import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/core/usecase/usecase.dart';
import 'package:chantier_plus/data/models/auth/create_user.dart';
import 'package:chantier_plus/domain/repository/auth/auth_repository.dart';
import 'package:chantier_plus/service_locator.dart';

class SignupUsecase extends UseCase<ServiceResult<String>, CreateUser> {
  @override
  Future<ServiceResult<String>> call({CreateUser? params}) async {
    return serviceLocator<AuthRepository>().signUp(params!);
  }
}
