import 'package:equatable/equatable.dart';

enum Gender { male, female }

enum Unit { cm, inch }

class WaistHipState extends Equatable {
  final double? ratio;
  final String? level;
  final Unit unit;
  final Gender gender;

  const WaistHipState({
    this.ratio,
    this.level,
    this.unit = Unit.cm,
    this.gender = Gender.male,
  });

  WaistHipState copyWith({
    double? ratio,
    String? level,
    Unit? unit,
    Gender? gender,
  }) {
    return WaistHipState(
      ratio: ratio,
      level: level,
      unit: unit ?? this.unit,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [ratio, level, unit, gender];
}
