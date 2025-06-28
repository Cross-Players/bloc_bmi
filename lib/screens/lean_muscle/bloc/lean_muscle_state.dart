import 'package:equatable/equatable.dart';

enum Gender { male, female }

enum HeightUnit { cm, feetInch }

enum WeightUnit { kg, lbs }

class LeanMuscleState extends Equatable {
  final Gender gender;
  final HeightUnit heightUnit;
  final WeightUnit weightUnit;
  final double? leanMuscleMass;

  const LeanMuscleState({
    this.gender = Gender.male,
    this.heightUnit = HeightUnit.cm,
    this.weightUnit = WeightUnit.kg,
    this.leanMuscleMass,
  });

  LeanMuscleState copyWith({
    Gender? gender,
    HeightUnit? heightUnit,
    WeightUnit? weightUnit,
    double? leanMuscleMass,
  }) {
    return LeanMuscleState(
      gender: gender ?? this.gender,
      heightUnit: heightUnit ?? this.heightUnit,
      weightUnit: weightUnit ?? this.weightUnit,
      leanMuscleMass: leanMuscleMass,
    );
  }

  @override
  List<Object?> get props => [gender, heightUnit, weightUnit, leanMuscleMass];
}
