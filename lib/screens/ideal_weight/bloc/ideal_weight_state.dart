import 'package:todo/screens/ideal_weight/bloc/ideal_weight_cubit.dart';

enum HeightUnit { cm, feetInch }

class IdealWeightState {
  final double? idealWeight;
  final BodyFrame? frame;
  final Gender? gender;
  final double? height; // luôn lưu dạng cm
  final HeightUnit heightUnit;

  IdealWeightState({
    this.idealWeight,
    this.frame,
    this.gender,
    this.height,
    this.heightUnit = HeightUnit.cm,
  });

  IdealWeightState copyWith({
    double? idealWeight,
    BodyFrame? frame,
    Gender? gender,
    double? height,
    HeightUnit? heightUnit,
  }) {
    return IdealWeightState(
      idealWeight: idealWeight ?? this.idealWeight,
      frame: frame ?? this.frame,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      heightUnit: heightUnit ?? this.heightUnit,
    );
  }
}
