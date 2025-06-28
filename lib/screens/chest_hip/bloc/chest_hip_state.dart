import 'package:equatable/equatable.dart';

enum Gender { male, female }

enum Unit { cm, inch }

class ChestHipState extends Equatable {
  final double? ratio;
  final String? level;
  final Unit unit;
  final Gender gender;

  const ChestHipState({
    this.ratio,
    this.level,
    this.unit = Unit.cm,
    this.gender = Gender.male,
  });

  ChestHipState copyWith({
    double? ratio,
    String? level,
    Unit? unit,
    Gender? gender,
  }) {
    return ChestHipState(
      ratio: ratio ?? this.ratio,
      level: level ?? this.level,
      unit: unit ?? this.unit,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [ratio, level, unit, gender];
}
