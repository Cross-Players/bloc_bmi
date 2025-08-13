import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/bmr/bloc/bmr_event.dart';
import 'package:todo/screens/bmr/bloc/bmr_state.dart';

class BmrBloc extends Bloc<BmrEvent, BmrState> {
  BmrBloc() : super(BmrState()) {
    on<UpdateAge>((event, emit) {
      emit(state.copyWith(age: event.age));
    });

    on<UpdateHeight>((event, emit) {
      emit(
        state.copyWith(
          heightUnit: event.unit,
          height1: event.value1,
          height2: event.value2,
        ),
      );
    });

    on<UpdateWeight>((event, emit) {
      emit(state.copyWith(weightUnit: event.unit, weight: event.value));
    });

    on<SelectGender>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<CalculateBMR>((event, emit) {
      final result = _calculateBMR();
      if (result == null) return;

      emit(
        BmrResultState(
          bmr: result,
          age: state.age,
          heightUnit: state.heightUnit,
          height1: state.height1,
          height2: state.height2,
          weightUnit: state.weightUnit,
          weight: state.weight,
          gender: state.gender,
        ),
      );
    });
  }

  double? _calculateBMR() {
    try {
      final int age = int.tryParse(state.age) ?? 0;
      if (age <= 0) return null;

      final double weight = double.tryParse(state.weight) ?? 0;
      if (weight <= 0) return null;
      final bool isLbs = state.weightUnit.toLowerCase() == 'lbs';
      final double weightKg = isLbs ? weight * 0.453592 : weight;

      double heightM = 0;
      if (state.heightUnit.toLowerCase() == 'feet') {
        final double feet = double.tryParse(state.height1) ?? 0;
        final double inch = double.tryParse(state.height2) ?? 0;
        final double totalInch = feet * 12 + inch;
        heightM = totalInch * 0.0254;
      } else {
        final double cm = double.tryParse(state.height1) ?? 0;
        heightM = cm / 100;
      }

      if (heightM <= 0) return null;
      final heightCm = heightM * 100;

      // Công thức BMR (Harris-Benedict)
      double bmr;
      if (state.gender == 'Nam') {
        bmr = 66.47 + (13.75 * weightKg) + (5.003 * heightCm) - (6.755 * age);
      } else {
        bmr = 655.1 + (9.563 * weightKg) + (1.850 * heightCm) - (4.676 * age);
      }

      return bmr;
    } catch (e, stack) {
      print('Lỗi tính BMR: $e');
      print(stack);
      return null;
    }
  }
}
