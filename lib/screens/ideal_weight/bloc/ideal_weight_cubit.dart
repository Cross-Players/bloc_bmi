import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/ideal_weight/bloc/ideal_weight_state.dart';

enum BodyFrame { light, medium, heavy }

enum Gender { male, female }

class IdealWeightCubit extends Cubit<IdealWeightState> {
  IdealWeightCubit()
    : super(IdealWeightState(gender: Gender.male, frame: BodyFrame.light));
  void setFrame(BodyFrame frame) {
    emit(state.copyWith(frame: frame));
  }

  void setGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void setHeightFromCm(double cm) {
    emit(state.copyWith(height: cm));
  }

  void setHeightFromFeetInch(int feet, int inch) {
    double cm = (feet * 30.48) + (inch * 2.54);
    emit(state.copyWith(height: cm));
  }

  void setHeightUnit(HeightUnit unit) {
    emit(state.copyWith(heightUnit: unit, height: null));
  }

  void calculateFromInput({required String height1, required String height2}) {
    if (state.heightUnit == HeightUnit.cm) {
      final cm = double.tryParse(height1);
      if (cm != null) {
        setHeightFromCm(cm);
      }
    } else {
      final feet = int.tryParse(height1) ?? 0;
      final inch = int.tryParse(height2) ?? 0;
      setHeightFromFeetInch(feet, inch);
    }

    calculate();
  }

  void calculate() {
    if (state.height == null || state.gender == null || state.frame == null)
      return;

    double base =
        state.gender == Gender.male ? state.height! - 100 : state.height! - 105;

    double modifier;
    switch (state.frame!) {
      case BodyFrame.light:
        modifier = 0.9;
        break;
      case BodyFrame.medium:
        modifier = 1.0;
        break;
      case BodyFrame.heavy:
        modifier = 1.1;
        break;
    }

    double result = base * modifier;
    emit(state.copyWith(idealWeight: result));
  }
}
