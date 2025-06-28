abstract class CaloriesBurnedEvent {}

class UpdateWeight extends CaloriesBurnedEvent {
  final String unit; // kg, lbs
  final String value;

  UpdateWeight({required this.unit, required this.value});
}

class UpdateDistance extends CaloriesBurnedEvent {
  final String unit; // km, mile
  final String value;

  UpdateDistance({required this.unit, required this.value});
}

class UpdateExerciseType extends CaloriesBurnedEvent {
  final String type; // Chạy hoặc Đi bộ

  UpdateExerciseType(this.type);
}

class CalculateCalories extends CaloriesBurnedEvent {}

class SubmitCaloriesCalculation extends CaloriesBurnedEvent {
  final String weight;
  final String weightUnit;
  final String distance;
  final String distanceUnit;
  final String exerciseType;

  SubmitCaloriesCalculation({
    required this.weight,
    required this.weightUnit,
    required this.distance,
    required this.distanceUnit,
    required this.exerciseType,
  });
}
