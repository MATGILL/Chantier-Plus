import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/data/models/auth/create_user.dart';
import 'package:chantier_plus/data/models/auth/login_user.dart';

/// L'interface `AuthRepository` représente le contrat de base pour l'implémentation
abstract class AuthRepository {
  /// Permet à un utilisateur de se connecter au système.
  Future<ServiceResult<String>> login(LoginUser user);

  /// Permet à un utilisateur de s'inscrire dans le système.
  Future<ServiceResult<String>> signUp(CreateUser user);
}
