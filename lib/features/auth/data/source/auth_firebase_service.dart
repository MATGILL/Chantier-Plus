import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/auth/data/models (Dto)/create_user.dart';
import 'package:chantier_plus/features/auth/data/models (Dto)/login_user.dart';
import 'package:chantier_plus/features/auth/domain/entities/user.dart';
import 'package:chantier_plus/features/auth/domain/repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service pour gérer l'authentification des utilisateurs avec Firebase.
class AuthFirebaseService extends AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Tente de connecter un utilisateur avec les informations d'identification fournies.
  ///
  /// Retourne un [ServiceResult] contenant un message de succès ou d'erreur.
  @override
  Future<ServiceResult<String>> login(LoginUser user) async {
    return await _handleAuthAction(
      () async {
        await _auth.signInWithEmailAndPassword(
            email: user.email, password: user.password);
        return ServiceResult<String>(content: "Login was successful");
      },
    );
  }

  /// Tente de créer un nouveau compte utilisateur avec les informations fournies.
  ///
  /// Retourne un [ServiceResult] contenant un message de succès ou d'erreur.
  @override
  Future<ServiceResult<String>> signUp(CreateUser user) async {
    return await _handleAuthAction(
      () async {
        // Crée l'utilisateur dans FirebaseAuth
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );

        // Ajoute l'utilisateur à Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': user.email,
          'fullName': user.fullName,
          'role': user.role,
          'createdAt': FieldValue.serverTimestamp(),
        });

        return ServiceResult<String>(content: "L'inscription a été réussie.");
      },
    );
  }

  /// Gère l'exécution d'une action d'authentification et la capture des erreurs.
  ///
  /// [action] est une fonction qui retourne un [ServiceResult].
  /// En cas d'exception [FirebaseAuthException], un message d'erreur approprié est retourné.
  Future<ServiceResult<String>> _handleAuthAction(
      Future<ServiceResult<String>> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      return ServiceResult(error: _getErrorMessage(e));
    }
  }

  @override
  Future<ServiceResult<UserEntity>> getUserById(String userId) async {
    try {
      // Récupérer les données de l'utilisateur depuis Firestore
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        // Extraire les informations de l'utilisateur
        final data = userSnapshot.data() as Map<String, dynamic>;
        final user = UserEntity(
          userId: userId,
          email: data['email'] ?? '',
          fullName: data['fullName'],
          role: data['role'] ?? '',
        );
        return ServiceResult<UserEntity>(content: user);
      } else {
        return ServiceResult<UserEntity>(error: "Utilisateur non trouvé.");
      }
    } catch (e) {
      return ServiceResult<UserEntity>(
          error: "Erreur lors de la récupération de l'utilisateur.");
    }
  }

  /// Retourne un message d'erreur basé sur le code d'erreur de l'exception FirebaseAuthException.
  ///
  /// [e] est l'exception capturée qui contient le code d'erreur.
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return "L'adresse e-mail fournie n'est pas valide.";
      case "user-disabled":
        return "L'utilisateur correspondant à cet e-mail a été désactivé.";
      case "user-not-found":
        return "Aucun utilisateur correspondant à cet e-mail n'a été trouvé.";
      case "wrong-password":
        return "Le mot de passe est incorrect.";
      case "too-many-requests":
        return "Trop de tentatives de connexion. Veuillez réessayer plus tard.";
      case "user-token-expired":
        return "Votre session a expiré. Veuillez vous reconnecter.";
      case "network-request-failed":
        return "Erreur de connexion réseau. Vérifiez votre connexion Internet.";
      case "invalid-credential":
      case "INVALID_LOGIN_CREDENTIALS":
        return "Les informations d'identification fournies sont invalides.";
      case "operation-not-allowed":
        return "La connexion par e-mail et mot de passe n'est pas activée.";
      case "email-already-in-use":
        return "Un compte existe déjà avec cette adresse e-mail.";
      case "weak-password":
        return "Le mot de passe fourni n'est pas assez fort.";
      default:
        return "Une erreur inconnue s'est produite. Veuillez réessayer.";
    }
  }
}
