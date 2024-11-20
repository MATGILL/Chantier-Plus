import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/auth/data/models%20(Dto)/create_user.dart';
import 'package:chantier_plus/features/auth/data/models%20(Dto)/login_user.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';

/// L'interface `AuthRepository` représente le contrat de base pour l'implémentation
/// des opérations d'authentification dans le système. Elle définit les méthodes
/// nécessaires pour gérer les connexions et les inscriptions des utilisateurs.
abstract class AuthRepository {
  /// Permet à un utilisateur de se connecter au système.
  ///
  /// Cette méthode prend en entrée une entité `UserEntity` et un mot de passe,
  /// et renvoie un `ServiceResult<String>` indiquant le résultat de l'opération.
  /// En cas de succès, le contenu renvoyé contient un message de confirmation.
  /// En cas d'échec, le `ServiceResult` contiendra une erreur décrivant
  /// la raison de l'échec (par exemple, email invalide, mot de passe incorrect).
  Future<ServiceResult<String>> login(LoginUser user);

  /// Permet à un utilisateur de s'inscrire dans le système.
  ///
  /// Cette méthode prend en entrée une entité `UserEntity` et un mot de passe,
  /// et renvoie un `ServiceResult<String>` indiquant le résultat de l'opération.
  /// En cas de succès, le contenu renvoyé contient un message de confirmation.
  /// En cas d'échec, le `ServiceResult` contiendra une erreur décrivant
  /// la raison de l'échec (par exemple, email déjà utilisé, informations manquantes).
  Future<ServiceResult<String>> signUp(CreateUser user);

  /// Récupère les informations d'un utilisateur à partir de son identifiant unique.
  ///
  /// Cette méthode prend en entrée l'ID de l'utilisateur sous forme de chaîne
  /// (`userId`) et renvoie un `ServiceResult<UserEntity>` représentant le résultat
  /// de l'opération.
  ///
  /// - En cas de succès : le contenu du `ServiceResult` contient une instance
  ///   de `UserEntity` représentant les informations de l'utilisateur, y compris
  ///   son ID, son email, son nom complet et son rôle.
  /// - En cas d'échec : le `ServiceResult` contiendra une erreur décrivant la raison
  ///   de l'échec (par exemple, utilisateur non trouvé, problème de connexion à la base
  ///   de données, ou autorisation refusée).
  Future<ServiceResult<UserEntity>> getUserById(String userId);
}
