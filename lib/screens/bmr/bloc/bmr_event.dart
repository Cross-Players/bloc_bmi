abstract class BmrEvent {}

class UpdateAge extends BmrEvent {
  final String age;
  UpdateAge(this.age);
}

class UpdateHeight extends BmrEvent {
  final String unit;
  final String value1;
  final String value2;
  UpdateHeight({
    required this.unit,
    required this.value1,
    required this.value2,
  });
}

class UpdateWeight extends BmrEvent {
  final String unit;
  final String value;
  UpdateWeight({required this.unit, required this.value});
}

class SelectGender extends BmrEvent {
  final String gender; // "Nam" hoặc "Nữ"
  SelectGender(this.gender);
}

class CalculateBMR extends BmrEvent {}
