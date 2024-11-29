import 'package:chantier_plus/core/service_result.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/construction_site.dart';
import 'package:chantier_plus/features/construction_site%20management/domain/entities/status.dart';

/// L'interface `ConstructionSiteRepository` définit les opérations nécessaires
/// pour gérer les sites de construction dans le système.
///
/// Cette interface agit comme un contrat entre la couche de domaine et les implémentations
/// spécifiques (comme celles utilisant Firestore ou une autre base de données).
/// Les résultats de chaque opération sont encapsulés dans des objets `ServiceResult`,
/// qui permettent de gérer les succès et les erreurs de manière centralisée.
abstract class ConstructionSiteRepository {
  /// Récupère un site de construction à partir de son identifiant unique.
  ///
  /// Cette méthode renvoie un `ServiceResult<ConstructionSite>` représentant
  /// le résultat de l'opération.
  ///
  /// - En cas de succès : le contenu du `ServiceResult` contient une instance
  ///   de `ConstructionSite`, représentant toutes les données du site.
  /// - En cas d'échec : le `ServiceResult` contiendra une erreur décrivant
  ///   la raison de l'échec (par exemple, ID invalide ou problème de connexion
  ///   à la base de données).
  ///
  /// Paramètres :
  /// - [id] : L'identifiant unique du site de construction à récupérer.
  Future<ServiceResult<ConstructionSite>> getById(String id);

  /// Récupère tous les sites de construction.
  ///
  /// Cette méthode renvoie un `ServiceResult<List<ConstructionSite>>` contenant
  /// la liste complète des sites de construction enregistrés.
  ///
  /// - En cas de succès : la liste des `ConstructionSite` est incluse
  ///   dans le `ServiceResult`.
  /// - En cas d'échec : le `ServiceResult` contiendra une erreur décrivant
  ///   la raison de l'échec (par exemple, problème de connexion à la base de données).
  Future<ServiceResult<List<ConstructionSite>>> getAll();

  /// Crée un nouveau site de construction.
  ///
  /// Cette méthode ajoute un site de construction à la base de données. Aucune
  /// valeur n'est retournée en cas de succès, mais des exceptions ou des erreurs
  /// peuvent être levées via `ServiceResult` en cas d'échec.
  ///
  /// Paramètres :
  /// - [constructionSite] : L'instance de `ConstructionSite` représentant
  ///   les données du site à créer.
  Future<void> create(ConstructionSite constructionSite);

  /// Met à jour un site de construction existant.
  ///
  /// Cette méthode met à jour les informations d'un site déjà enregistré
  /// dans la base de données.
  ///
  /// - En cas de succès : les nouvelles données sont enregistrées.
  /// - En cas d'échec : une erreur est levée (par exemple, ID introuvable).
  ///
  /// Paramètres :
  /// - [constructionSite] : L'instance mise à jour de `ConstructionSite`.
  Future<void> update(ConstructionSite constructionSite);

  /// Supprime un site de construction à partir de son identifiant unique.
  ///
  /// Cette méthode retire le site de construction correspondant à l'ID fourni
  /// de la base de données.
  ///
  /// - En cas de succès : le site est supprimé.
  /// - En cas d'échec : une erreur est levée (par exemple, ID introuvable ou problème
  ///   de droits d'accès).
  ///
  /// Paramètres :
  /// - [id] : L'identifiant unique du site de construction à supprimer.
  Future<void> delete(String id);

  /// Change le statut d'un chantier dans Firestore.
  ///
  /// [id] : ID du chantier à mettre à jour.
  ///
  /// [newStatus] : Nouveau statut à définir.
  Future<ServiceResult<String>> changeStatus(String id, Status newStatus);

  ///Ajoute une anomaly à un chantier
  ///
  /// [siteId] : l'id du chantier à metter à jours
  ///
  /// [anomalyId] : Nouveau statut à définir.
  Future<ServiceResult<void>> addAnomalyToConstructionSite(
      String siteId, String anomalyId);
}
