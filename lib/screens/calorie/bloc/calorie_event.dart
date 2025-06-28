import 'package:todo/screens/calorie/model/activity_level.dart';

abstract class CalorieEvent {}

class UpdateAge extends CalorieEvent {
  final String age;
  UpdateAge(this.age);
}

class UpdateHeight extends CalorieEvent {
  final String unit;
  final String value1;
  final String value2;
  UpdateHeight({
    required this.unit,
    required this.value1,
    required this.value2,
  });
}

class UpdateWeight extends CalorieEvent {
  final String unit;
  final String value;
  UpdateWeight({required this.unit, required this.value});
}

class SelectActivityLevel extends CalorieEvent {
  final ActivityLevel level;
  SelectActivityLevel(this.level);
}

class SelectGender extends CalorieEvent {
  final String gender; // "Nam" hoặc "Nữ"
  SelectGender(this.gender);
}

class CalculateTTDE extends CalorieEvent {}
