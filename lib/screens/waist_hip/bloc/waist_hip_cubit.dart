import 'package:flutter_bloc/flutter_bloc.dart';
import 'waist_hip_state.dart';

class WaistHipCubit extends Cubit<WaistHipState> {
  WaistHipCubit() : super(const WaistHipState());

  void setUnit(Unit unit) => emit(state.copyWith(unit: unit));
  void setGender(Gender gender) => emit(state.copyWith(gender: gender));

  void calculateRatio({required String waistText, required String hipText}) {
    double waist = double.tryParse(waistText) ?? 0;
    double hip = double.tryParse(hipText) ?? 0;

    if (waist == 0 || hip == 0) {
      emit(state.copyWith(ratio: null, level: null));
      return;
    }

    if (state.unit == Unit.inch) {
      waist *= 2.54;
      hip *= 2.54;
    }

    final ratio = waist / hip;
    final level = _classifyWHR(ratio, state.gender);

    emit(state.copyWith(ratio: ratio, level: level));
  }

  String _classifyWHR(double ratio, Gender gender) {
    if (gender == Gender.male) {
      return ratio >= 0.90 ? 'Nguy cơ cao' : 'Bình thường';
    } else {
      return ratio >= 0.85 ? 'Nguy cơ cao' : 'Bình thường';
    }
  }
}
