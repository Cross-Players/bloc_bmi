import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/body_frame/bloc/body_frame_state.dart';

class BodyFrameCubit extends Cubit<BodyFrameState> {
  BodyFrameCubit() : super(const BodyFrameState());

  void setGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void setHeightUnit(HeightUnit unit) {
    emit(state.copyWith(heightUnit: unit));
  }

  void setWristUnit(WristUnit unit) {
    emit(state.copyWith(wristUnit: unit));
  }

  void calculateFrameSize({
    required String height1,
    required String height2,
    required String wristText,
  }) {
    double heightCm = 0;
    double wristCm = 0;

    // Chuyển đổi chiều cao
    if (state.heightUnit == HeightUnit.cm) {
      heightCm = double.tryParse(height1) ?? 0;
    } else {
      double feet = double.tryParse(height1) ?? 0;
      double inch = double.tryParse(height2) ?? 0;
      heightCm = ((feet * 12) + inch) * 2.54;
    }

    // Chuyển đổi cổ tay
    double wrist = double.tryParse(wristText) ?? 0;
    wristCm = state.wristUnit == WristUnit.cm ? wrist : wrist * 2.54;

    if (heightCm == 0 || wristCm == 0) {
      emit(state.copyWith(frameSize: null, ratio: null));
      return;
    }

    double ratio = heightCm / wristCm;
    String size;

    if (state.gender == Gender.male) {
      if (ratio > 10.4) {
        size = 'Nhỏ';
      } else if (ratio >= 9.6) {
        size = 'Trung bình';
      } else {
        size = 'Lớn';
      }
    } else {
      if (ratio > 11.0) {
        size = 'Nhỏ';
      } else if (ratio >= 10.1) {
        size = 'Trung bình';
      } else {
        size = 'Lớn';
      }
    }

    emit(state.copyWith(ratio: ratio, frameSize: size));
  }
}
