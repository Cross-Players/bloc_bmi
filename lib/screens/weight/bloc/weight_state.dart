import 'package:todo/screens/weight/model/weight_history.dart';

enum WeightStep { inputCurrent, inputGoal, inputActivity, completed }

class WeightState {
  final WeightStep step;
  final String? currentWeight;
  final String? goalWeight;
  final int? activityLevel;
  final double? targetWeightDiff;
  final String? currentWeightDate;
  final List<WeightHistory> weightHistory;

  WeightState({
    required this.step,
    this.currentWeight,
    this.goalWeight,
    this.activityLevel,
    this.targetWeightDiff,
    this.currentWeightDate,
    this.weightHistory = const [],
  });

  factory WeightState.initial() {
    return WeightState(step: WeightStep.inputCurrent);
  }

  WeightState copyWith({
    WeightStep? step,
    String? currentWeight,
    String? goalWeight,
    int? activityLevel,
    double? targetWeightDiff,
    String? currentWeightDate,
    List<WeightHistory>? weightHistory,
  }) {
    return WeightState(
      step: step ?? this.step,
      currentWeight: currentWeight ?? this.currentWeight,
      goalWeight: goalWeight ?? this.goalWeight,
      activityLevel: activityLevel ?? this.activityLevel,
      targetWeightDiff: targetWeightDiff ?? this.targetWeightDiff,
      currentWeightDate: currentWeightDate ?? this.currentWeightDate,
      weightHistory: weightHistory ?? this.weightHistory,
    );
  }
}
