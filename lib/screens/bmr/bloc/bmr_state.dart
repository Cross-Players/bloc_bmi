class BmrState {
  final String age;
  final String heightUnit;
  final String height1;
  final String height2;
  final String weightUnit;
  final String weight;
  final String gender;

  const BmrState({
    this.age = '',
    this.heightUnit = 'feet',
    this.height1 = '',
    this.height2 = '',
    this.weightUnit = 'kg',
    this.weight = '',
    this.gender = 'Nam',
  });

  BmrState copyWith({
    String? age,
    String? heightUnit,
    String? height1,
    String? height2,
    String? weightUnit,
    String? weight,
    String? gender,
  }) {
    return BmrState(
      age: age ?? this.age,
      heightUnit: heightUnit ?? this.heightUnit,
      height1: height1 ?? this.height1,
      height2: height2 ?? this.height2,
      weightUnit: weightUnit ?? this.weightUnit,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
    );
  }
}

class BmrResultState extends BmrState {
  final double bmr;

  const BmrResultState({
    required this.bmr,
    required super.age,
    required super.heightUnit,
    required super.height1,
    required super.height2,
    required super.weightUnit,
    required super.weight,
    required super.gender,
  });
}
