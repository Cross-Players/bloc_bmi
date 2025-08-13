import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/lean_muscle/bloc/lean_muscle_state.dart';

class LeanMuscleCubit extends Cubit<LeanMuscleState> {
  LeanMuscleCubit() : super(const LeanMuscleState());

  void setGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void setHeightUnit(HeightUnit unit) {
    emit(state.copyWith(heightUnit: unit));
  }

  void setWeightUnit(WeightUnit unit) {
    emit(state.copyWith(weightUnit: unit));
  }

  void calculateLeanMass({
    required String height1,
    required String height2,
    required String weightText,
  }) {
    try {
      double heightCm = 0;
      double weightKg = 0;

      if (state.heightUnit == HeightUnit.cm) {
        heightCm = double.tryParse(height1) ?? 0;
      } else {
        double feet = double.tryParse(height1) ?? 0;
        double inch = double.tryParse(height2) ?? 0;
        heightCm = ((feet * 12) + inch) * 2.54;
      }

      double weight = double.tryParse(weightText) ?? 0;
      weightKg = state.weightUnit == WeightUnit.kg ? weight : weight * 0.453592;

      if (heightCm <= 0 || weightKg <= 0) {
        emit(state.copyWith(leanMuscleMass: null));
        return;
      }

      double leanMass;
      if (state.gender == Gender.male) {
        leanMass = (0.407 * weightKg) + (0.267 * heightCm) - 19.2;
      } else {
        leanMass = (0.252 * weightKg) + (0.473 * heightCm) - 48.3;
      }

      emit(state.copyWith(leanMuscleMass: leanMass));
    } catch (_) {
      emit(state.copyWith(leanMuscleMass: null));
    }
  }
}
