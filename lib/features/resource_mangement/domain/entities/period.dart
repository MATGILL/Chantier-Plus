import 'package:chantier_plus/common/utils/utils_date.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';

class Period {
  final HalfDay halfDayStart;
  final DateTime startingDate;
  final int durationInHalfDay;

  Period({
    required this.halfDayStart,
    required this.startingDate,
    required this.durationInHalfDay,
  });

  // fromJson
  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      halfDayStart: HalfDay.values.byName(json['halfDayStarting'] as String),
      startingDate: DateTime.parse(json['startingDate']),
      durationInHalfDay: json['durationInHalfDay'],
    );
  }

  Period.empty()
      : durationInHalfDay = 0,
        startingDate = DateTime.now(),
        halfDayStart = HalfDay.afternoon;

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'halfDayStarting': halfDayStart.toFirebaseFormat(),
      'startingDate': startingDate.toIso8601String(),
      'durationInHalfDay': durationInHalfDay,
    };
  }

  /// Vérifie si une période donnée chevauche la période actuelle.
  ///
  /// Cette méthode compare une période définie par un point de départ
  /// (`startingDate`) et une durée en demi-journées (`durationInHalfDay`) avec
  /// la période actuelle représentée par les attributs de l'objet.
  ///
  /// ### Paramètres
  /// - [halfDayStart] : Indique si la période donnée commence le matin ou l'après-midi.
  /// - [startingDate] : La date de début de la période donnée.
  /// - [durationInHalfDay] : La durée de la période donnée en demi-journées.
  ///
  /// ### Retourne
  /// - `true` si les périodes se chevauchent.
  /// - `false` sinon.
  ///
  /// ### Logique
  /// - La date et la demi-journée sont normalisées pour permettre une comparaison.
  /// - Une période est définie par une date de début et de fin calculée à partir
  ///   de la durée en demi-journées.
  /// - La méthode vérifie si les points de début ou de fin de l'une des périodes
  ///   tombent dans l'intervalle de l'autre période, ou si elles se touchent.
  bool isOverlaps(
      HalfDay halfDayStart, DateTime startingDate, int durationInHalfDay) {
    // Vérifier si une période est vide
    if (durationInHalfDay == 0 || this.durationInHalfDay == 0) {
      return false;
    }

    // Normaliser la période donnée
    var normalizeDateStart = normalizeDate(startingDate);
    if (halfDayStart == HalfDay.afternoon) {
      normalizeDateStart = normalizeDateStart.add(const Duration(hours: 12));
    }

    var normalizeDateEnd =
        normalizeDateStart.add(Duration(days: (durationInHalfDay / 2).floor()));
    if (durationInHalfDay % 2 == 1) {
      normalizeDateEnd = normalizeDateEnd.add(const Duration(hours: 12));
    }

    // Normaliser la période actuelle
    var currentDateStart = normalizeDate(this.startingDate);
    if (this.halfDayStart == HalfDay.afternoon) {
      currentDateStart = currentDateStart.add(const Duration(hours: 12));
    }

    var currentDateEnd = currentDateStart
        .add(Duration(days: (this.durationInHalfDay / 2).floor()));
    if (this.durationInHalfDay % 2 == 1) {
      currentDateEnd = currentDateEnd.add(const Duration(hours: 12));
    }

    // Vérifier si une période se termine avant que l'autre ne commence
    if (normalizeDateEnd.isBefore(currentDateStart) ||
        currentDateEnd.isBefore(normalizeDateStart)) {
      return false;
    }

    // Logique de chevauchement
    if (normalizeDateStart.isAfter(currentDateStart) &&
        normalizeDateStart.isBefore(currentDateEnd)) {
      return true;
    }

    if (normalizeDateEnd.isAfter(currentDateStart) &&
        normalizeDateEnd.isBefore(currentDateEnd)) {
      return true;
    }

    if ((normalizeDateStart.isBefore(currentDateStart) ||
            normalizeDateStart.isAtSameMomentAs(currentDateStart)) &&
        (normalizeDateEnd.isAfter(currentDateEnd) ||
            normalizeDateEnd.isAtSameMomentAs(currentDateEnd))) {
      return true;
    }

    if ((currentDateStart.isBefore(normalizeDateStart) ||
            currentDateStart.isAtSameMomentAs(normalizeDateStart)) &&
        (currentDateEnd.isAfter(normalizeDateEnd) ||
            currentDateEnd.isAtSameMomentAs(normalizeDateEnd))) {
      return true;
    }

    return false;
  }
}
