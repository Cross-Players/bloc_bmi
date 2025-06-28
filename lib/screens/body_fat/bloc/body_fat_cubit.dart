import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/body_fat/bloc/body_fat_state.dart';

class BodyFatCubit extends Cubit<BodyFatState> {
  BodyFatCubit() : super(const BodyFatState());

  void setGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void setHeightUnit(HeightUnit unit) {
    emit(state.copyWith(heightUnit: unit));
  }

  void setUnit(Unit unit) {
    emit(state.copyWith(unit: unit));
  }

  void calculateBodyFatSimple({
    required String height1,
    required String height2,
    required String hipText,
  }) {
    double heightCm = 0;

    if (state.heightUnit == HeightUnit.cm) {
      heightCm = double.tryParse(height1) ?? 0;
    } else {
      double feet = double.tryParse(height1) ?? 0;
      double inch = double.tryParse(height2) ?? 0;
      heightCm = ((feet * 12) + inch) * 2.54;
    }

    double hip = double.tryParse(hipText) ?? 0;
    if (state.unit == Unit.inch) {
      hip = hip * 2.54;
    }

    if (heightCm == 0 || hip == 0) {
      emit(state.copyWith(bodyFatPercent: null, level: null));
      return;
    }

    double ratio = hip / heightCm;
    double percent = ratio * 100; // có thể coi như % tương đối

    String level;
    if (ratio < 0.49) {
      level = "Underweight";
    } else if (ratio < 0.55) {
      level = "Normal";
    } else if (ratio < 0.59) {
      level = "Overweight";
    } else {
      level = "Obese";
    }

    emit(state.copyWith(bodyFatPercent: percent, level: level));
  }
}
