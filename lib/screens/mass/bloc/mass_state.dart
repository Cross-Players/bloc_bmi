import 'package:equatable/equatable.dart';

enum MassWayType { standard, newWay }

class MassState extends Equatable {
  final String age;
  final String heightUnit;
  final String height1;
  final String height2;
  final String weightUnit;
  final String weight;
  final MassWayType selected;

  const MassState({
    this.age = '',
    this.heightUnit = 'cm',
    this.height1 = '',
    this.height2 = '',
    this.weightUnit = 'kg',
    this.weight = '',
    this.selected = MassWayType.standard,
  });

  MassState copyWith({
    String? age,
    String? heightUnit,
    String? height1,
    String? height2,
    String? weightUnit,
    String? weight,
    MassWayType? selected,
  }) {
    return MassState(
      age: age ?? this.age,
      heightUnit: heightUnit ?? this.heightUnit,
      height1: height1 ?? this.height1,
      height2: height2 ?? this.height2,
      weightUnit: weightUnit ?? this.weightUnit,
      weight: weight ?? this.weight,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [
    age,
    heightUnit,
    height1,
    height2,
    weightUnit,
    weight,
    selected,
  ];
}

class MassResultState extends MassState {
  final double bmi;
  final String category;

  const MassResultState({
    required this.bmi,
    required this.category,
    required super.age,
    required super.heightUnit,
    required super.height1,
    required super.height2,
    required super.weightUnit,
    required super.weight,
    required super.selected,
  });
}
