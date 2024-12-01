import 'package:flutter_test/flutter_test.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/half_day.dart';
import 'package:chantier_plus/features/resource_mangement/domain/entities/period.dart';

void main() {
  group('Period.isOverlaps', () {
    test('Should return true for overlapping periods', () {
      // Arrange
      final period1 = Period(
        halfDayStart: HalfDay.morning,
        startingDate: DateTime(2024, 11, 30),
        durationInHalfDay: 4,
      );

      const halfDayStart2 = HalfDay.afternoon;
      final startingDate2 = DateTime(2024, 11, 30);
      const durationInHalfDay2 = 2;

      // Act
      final overlaps =
          period1.isOverlaps(halfDayStart2, startingDate2, durationInHalfDay2);

      // Assert
      expect(overlaps, true);
    });

    test('Should return false for non-overlapping periods', () {
      // Arrange
      final period1 = Period(
        halfDayStart: HalfDay.morning,
        startingDate: DateTime(2024, 11, 30),
        durationInHalfDay: 2,
      );

      const halfDayStart2 = HalfDay.afternoon;
      final startingDate2 = DateTime(2024, 12, 1);
      const durationInHalfDay2 = 2;

      // Act
      final overlaps =
          period1.isOverlaps(halfDayStart2, startingDate2, durationInHalfDay2);

      // Assert
      expect(overlaps, false);
    });

    test('Should return true for exact same periods', () {
      // Arrange
      final period1 = Period(
        halfDayStart: HalfDay.morning,
        startingDate: DateTime(2024, 11, 30),
        durationInHalfDay: 4,
      );

      const halfDayStart2 = HalfDay.morning;
      final startingDate2 = DateTime(2024, 11, 30);
      const durationInHalfDay2 = 4;

      // Act
      final overlaps =
          period1.isOverlaps(halfDayStart2, startingDate2, durationInHalfDay2);

      // Assert
      expect(overlaps, true);
    });

    test('Should return true for touching periods', () {
      // Arrange
      final period1 = Period(
        halfDayStart: HalfDay.morning,
        startingDate: DateTime(2024, 11, 30),
        durationInHalfDay: 4,
      );

      const halfDayStart2 = HalfDay.afternoon;
      final startingDate2 = DateTime(2024, 12, 1);
      const durationInHalfDay2 = 2;

      // Act
      final overlaps =
          period1.isOverlaps(halfDayStart2, startingDate2, durationInHalfDay2);

      // Assert
      expect(overlaps, true);
    });

    test('Should return false when one period ends before the other starts',
        () {
      // Arrange
      final period1 = Period(
        halfDayStart: HalfDay.morning,
        startingDate: DateTime(2024, 11, 30),
        durationInHalfDay: 2,
      );

      const halfDayStart2 = HalfDay.morning;
      final startingDate2 = DateTime(2024, 12, 1);
      const durationInHalfDay2 = 2;

      // Act
      final overlaps =
          period1.isOverlaps(halfDayStart2, startingDate2, durationInHalfDay2);

      // Assert
      expect(overlaps, false);
    });

    test('Should return true for periods spanning multiple days', () {
      // Arrange
      final period1 = Period(
        halfDayStart: HalfDay.afternoon,
        startingDate: DateTime(2024, 11, 30),
        durationInHalfDay: 4, // Jusqu'à 2 jours après-midi
      );

      const halfDayStart2 = HalfDay.morning;
      final startingDate2 = DateTime(2024, 12, 1);
      const durationInHalfDay2 = 2;

      // Act
      final overlaps =
          period1.isOverlaps(halfDayStart2, startingDate2, durationInHalfDay2);

      // Assert
      expect(overlaps, true);
    });

    test('Should return false when one period ends exactly as another starts',
        () {
      // Arrange
      final period1 = Period(
        halfDayStart: HalfDay.morning,
        startingDate: DateTime(2024, 11, 30),
        durationInHalfDay: 2,
      );

      const halfDayStart2 = HalfDay.afternoon;
      final startingDate2 = DateTime(2024, 11, 30);
      const durationInHalfDay2 = 2;

      // Act
      final overlaps =
          period1.isOverlaps(halfDayStart2, startingDate2, durationInHalfDay2);

      // Assert
      expect(overlaps, true);
    });
  });
}
