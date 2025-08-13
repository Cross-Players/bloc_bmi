import 'package:equatable/equatable.dart';

enum Gender { male, female }

enum Unit { cm, inch }

enum HeightUnit { cm, feetInch }

class WaistHeightState extends Equatable {
  final double? ratio;
  final String? level;
  final Unit unit;
  final HeightUnit heightUnit;
  final Gender gender;

  const WaistHeightState({
    this.ratio,
    this.level,
    this.unit = Unit.cm,
    this.heightUnit = HeightUnit.cm,
    this.gender = Gender.male,
  });

  @override
  List<Object?> get props => [ratio, level, unit, heightUnit, gender];

  WaistHeightState copyWith({
    double? ratio,
    String? level,
    Unit? unit,
    HeightUnit? heightUnit,
    Gender? gender,
  }) {
    return WaistHeightState(
      ratio: ratio,
      level: level,
      unit: unit ?? this.unit,
      heightUnit: heightUnit ?? this.heightUnit,
      gender: gender ?? this.gender,
    );
  }
}
