class CaloriesBurnedState {
  final String weight;
  final String weightUnit;
  final String distance;
  final String distanceUnit;
  final String exerciseType;

  const CaloriesBurnedState({
    this.weight = '',
    this.weightUnit = 'kg',
    this.distance = '',
    this.distanceUnit = 'km',
    this.exerciseType = 'Chạy',
  });

  CaloriesBurnedState copyWith({
    String? weight,
    String? weightUnit,
    String? distance,
    String? distanceUnit,
    String? exerciseType,
  }) {
    return CaloriesBurnedState(
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      distance: distance ?? this.distance,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      exerciseType: exerciseType ?? this.exerciseType,
    );
  }
}

class CaloriesBurnedResultState extends CaloriesBurnedState {
  final double calories;

  const CaloriesBurnedResultState({
    required this.calories,
    required super.weight,
    required super.weightUnit,
    required super.distance,
    required super.distanceUnit,
    required super.exerciseType,
  });
}
