import 'package:chantier_plus/features/auth/data/models%20(Dto)/create_user.dart';
import 'package:chantier_plus/features/auth/data/models%20(Dto)/login_user.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';

class UserMapper {
  /// Transforme un [UserEntity] en [LoginUser].
  static LoginUser toLoginDto(UserEntity user, String password) {
    return LoginUser(
      email: user.email!,
      password: password,
    );
  }

  /// Transforme un [UserEntity] en [CreateUser].
  static CreateUser toCreateDto(UserEntity user, String password) {
    return CreateUser(
      email: user.email!,
      password: password,
      fullName: user.fullName!,
    );
  }

  /// Transforme un [LoginUser] en [UserEntity].
  static UserEntity fromLoginDto(LoginUser dto) {
    return UserEntity(
      email: dto.email,
      // On peut omettre le mot de passe ici car il ne devrait pas être stocké
    );
  }

  /// Transforme un [CreateUser] en [UserEntity].
  static UserEntity fromCreateDto(CreateUser dto) {
    return UserEntity(
      email: dto.email,
      fullName: dto.fullName,
    );
  }
}
