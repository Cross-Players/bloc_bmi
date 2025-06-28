import 'package:flutter_bloc/flutter_bloc.dart';
import 'chest_hip_state.dart';

class ChestHipCubit extends Cubit<ChestHipState> {
  ChestHipCubit() : super(const ChestHipState());

  void setGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void setUnit(Unit unit) {
    emit(state.copyWith(unit: unit));
  }

  void calculateRatio({required String chestText, required String hipText}) {
    double chest = double.tryParse(chestText) ?? 0;
    double hip = double.tryParse(hipText) ?? 0;

    if (chest == 0 || hip == 0) {
      emit(state.copyWith(ratio: null, level: null));
      return;
    }

    if (state.unit == Unit.inch) {
      chest *= 2.54;
      hip *= 2.54;
    }

    final ratio = chest / hip;
    final level = _classifyRatio(ratio);

    emit(state.copyWith(ratio: ratio, level: level));
  }

  String _classifyRatio(double ratio) {
    if (ratio > 1.05) {
      return "Tam giác ngược (ngực to hơn hông)";
    } else if (ratio >= 0.95) {
      return "Đồng hồ cát (cân đối)";
    } else if (ratio >= 0.85) {
      return "Hình quả lê (hông to hơn)";
    } else {
      return "Hình tam giác (hông lớn, ngực nhỏ)";
    }
  }
}
