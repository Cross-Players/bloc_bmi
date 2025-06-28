import 'package:todo/screens/calorie/model/activity_level.dart';

class CalorieState {
  final String age;
  final String heightUnit;
  final String height1;
  final String height2;
  final String weightUnit;
  final String weight;
  final String gender;
  final ActivityLevel? activityLevel;

  const CalorieState({
    this.age = '',
    this.heightUnit = 'feet',
    this.height1 = '',
    this.height2 = '',
    this.weightUnit = 'kg',
    this.weight = '',
    this.gender = 'Nam',
    this.activityLevel,
  });

  CalorieState copyWith({
    String? age,
    String? heightUnit,
    String? height1,
    String? height2,
    String? weightUnit,
    String? weight,
    String? gender,
    ActivityLevel? activityLevel,
  }) {
    return CalorieState(
      age: age ?? this.age,
      heightUnit: heightUnit ?? this.heightUnit,
      height1: height1 ?? this.height1,
      height2: height2 ?? this.height2,
      weightUnit: weightUnit ?? this.weightUnit,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }
}

class CalorieResultState extends CalorieState {
  final double tdee;

  const CalorieResultState({
    required this.tdee,
    required super.age,
    required super.heightUnit,
    required super.height1,
    required super.height2,
    required super.weightUnit,
    required super.weight,
    required super.gender,
    required super.activityLevel,
  });
}
