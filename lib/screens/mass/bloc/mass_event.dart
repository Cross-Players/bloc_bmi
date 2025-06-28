import 'package:todo/screens/mass/bloc/mass_state.dart';

abstract class MassEvent {}

class UpdateAge extends MassEvent {
  final String age;
  UpdateAge(this.age);
}

class UpdateHeight extends MassEvent {
  final String unit;
  final String value1;
  final String value2;
  UpdateHeight({
    required this.unit,
    required this.value1,
    required this.value2,
  });
}

class UpdateWeight extends MassEvent {
  final String unit;
  final String value;
  UpdateWeight({required this.unit, required this.value});
}

class SelectMassWay extends MassEvent {
  final MassWayType selected;
  SelectMassWay(this.selected);
}

class CalculateBMI extends MassEvent {}
