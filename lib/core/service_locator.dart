import 'package:chantier_plus/features/auth/domain/repository/auth_repository.dart';
import 'package:chantier_plus/features/auth/domain/services/auth_service.dart';
import 'package:chantier_plus/features/auth/data/source/auth_firebase_service.dart';
import 'package:get_it/get_it.dart';

/// Configuration du service locator pour l'application.
///
/// Cette fonction initialise et enregistre les différentes
/// instances nécessaires à travers l'application, suivant
/// le principe de l'injection de dépendances.
///
/// ne pas confondre avec inhjection de dépendance.

final GetIt serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  //Authentification services
  await initializeAuthServices();
}

Future<void> initializeAuthServices() async {
  serviceLocator.registerSingleton<AuthRepository>(AuthFirebaseService());
  serviceLocator.registerSingleton<AuthService>(
      AuthService(serviceLocator<AuthRepository>()));
}
