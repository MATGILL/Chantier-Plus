import 'package:chantier_plus/data/models/auth/create_user.dart';

/// L'interface `AuthRepository` représente le contrat de base pour l'implémentation
abstract class AuthRepository {
  /// Permet à un utilisateur de se connecter au système.
  Future<void> login();

  /// Permet à un utilisateur de s'inscrire dans le système.
  Future<void> signUp(CreateUser user);
}
