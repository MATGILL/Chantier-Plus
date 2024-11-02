/// La classe abstraite `UseCase` représente un modèle de cas d'utilisation (Use Case)
/// dans l'architecture de type Clean Architecture.
///
/// Un `UseCase` encapsule une opération spécifique liée à la logique métier.
/// Il permet de séparer la logique de traitement des entités et d'assurer que
/// l'application reste découplée et maintenable.
///
/// Cette classe est paramétrée de manière générique pour accepter différents
/// types de résultats ([Type]) et de paramètres ([Params]) afin de rester flexible
/// et adaptable aux divers cas d'utilisation.
abstract class UseCase<Type, Params> {
  /// Méthode abstraite qui doit être implémentée par chaque cas d'utilisation.
  ///
  /// Cette méthode exécute l'opération métier associée au cas d'utilisation.
  ///
  /// - [params] : les paramètres nécessaires pour exécuter le cas d'utilisation.
  ///   Cette méthode accepte des paramètres nommés afin de permettre une meilleure lisibilité.
  ///
  /// Retourne un [Future] de type [Type], représentant le résultat de l'opération
  /// lorsque celle-ci est complétée.
  Future<Type> call({Params params});
}
