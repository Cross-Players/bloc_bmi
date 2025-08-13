abstract class WeightEvent {}

class CheckWeightStatus extends WeightEvent {}

class SubmitCurrentWeight extends WeightEvent {
  final String weight;

  SubmitCurrentWeight(this.weight);
}

class SubmitGoalWeight extends WeightEvent {
  final String weight;

  SubmitGoalWeight(this.weight);
}

class SubmitActivityLevel extends WeightEvent {
  final int levelIndex;

  SubmitActivityLevel(this.levelIndex);
}

class SelectActivityLevel extends WeightEvent {
  final int levelIndex;
  SelectActivityLevel(this.levelIndex);
}

class DeleteWeightHistory extends WeightEvent {
  final String key; // key thật: 'weight_2025-06-24T10:00:00'

  DeleteWeightHistory(this.key);
}

class ClearAllWeightData extends WeightEvent {}
