import 'package:flutter_bloc/flutter_bloc.dart';
import 'waist_height_state.dart';

class WaistHeightCubit extends Cubit<WaistHeightState> {
  WaistHeightCubit() : super(const WaistHeightState());

  void setUnit(Unit unit) => emit(state.copyWith(unit: unit));
  void setHeightUnit(HeightUnit unit) => emit(state.copyWith(heightUnit: unit));
  void setGender(Gender gender) => emit(state.copyWith(gender: gender));

  void calculateRatio({
    required String waistText,
    required String height1,
    required String height2,
  }) {
    double waist = double.tryParse(waistText) ?? 0;

    double height = 0;
    if (state.heightUnit == HeightUnit.cm) {
      height = double.tryParse(height1) ?? 0;
    } else {
      double feet = double.tryParse(height1) ?? 0;
      double inch = double.tryParse(height2) ?? 0;
      height = ((feet * 12) + inch) * 2.54;
    }

    if (state.unit == Unit.inch) {
      waist *= 2.54;
    }

    if (waist == 0 || height == 0) {
      emit(state.copyWith(ratio: null, level: null));
      return;
    }

    double ratio = waist / height;
    String level = classifyWHtR(ratio, state.gender);

    emit(state.copyWith(ratio: ratio, level: level));
  }

  String classifyWHtR(double ratio, Gender gender) {
    if (ratio < 0.4) {
      return "Gầy";
    } else if (ratio < 0.5) {
      return "Bình thường";
    } else if (ratio < 0.6) {
      return "Thừa mỡ";
    } else {
      return "Nguy cơ cao";
    }
  }
}
