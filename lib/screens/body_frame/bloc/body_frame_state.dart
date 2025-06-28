import 'package:equatable/equatable.dart';

enum Gender { male, female }

enum HeightUnit { cm, feetInch }

enum WristUnit { cm, inch }

class BodyFrameState extends Equatable {
  final Gender gender;
  final HeightUnit heightUnit;
  final WristUnit wristUnit;
  final String? frameSize;
  final double? ratio;

  const BodyFrameState({
    this.gender = Gender.male,
    this.heightUnit = HeightUnit.cm,
    this.wristUnit = WristUnit.cm,
    this.frameSize,
    this.ratio,
  });

  BodyFrameState copyWith({
    Gender? gender,
    HeightUnit? heightUnit,
    WristUnit? wristUnit,
    String? frameSize,
    double? ratio,
  }) {
    return BodyFrameState(
      gender: gender ?? this.gender,
      heightUnit: heightUnit ?? this.heightUnit,
      wristUnit: wristUnit ?? this.wristUnit,
      frameSize: frameSize,
      ratio: ratio,
    );
  }

  @override
  List<Object?> get props => [gender, heightUnit, wristUnit, frameSize, ratio];
}
