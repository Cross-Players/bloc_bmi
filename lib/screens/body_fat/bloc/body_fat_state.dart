import 'package:equatable/equatable.dart';

enum Gender { male, female }

enum HeightUnit { cm, feetInch }

enum Unit { cm, inch }

class BodyFatState extends Equatable {
  final Gender gender;
  final HeightUnit heightUnit;
  final Unit unit;
  final double? bodyFatPercent;
  final String? level;

  const BodyFatState({
    this.gender = Gender.male,
    this.heightUnit = HeightUnit.cm,
    this.unit = Unit.cm,
    this.bodyFatPercent,
    this.level,
  });

  BodyFatState copyWith({
    Gender? gender,
    HeightUnit? heightUnit,
    Unit? unit,
    double? bodyFatPercent,
    String? level,
  }) {
    return BodyFatState(
      gender: gender ?? this.gender,
      heightUnit: heightUnit ?? this.heightUnit,
      unit: unit ?? this.unit,
      bodyFatPercent: bodyFatPercent,
      level: level,
    );
  }

  @override
  List<Object?> get props => [gender, heightUnit, unit, bodyFatPercent, level];
}
