import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/calorie/bloc/calorie_event.dart';
import 'package:todo/screens/calorie/bloc/calorie_state.dart';
import 'package:todo/screens/calorie/model/activity_level.dart';

class CalorieBloc extends Bloc<CalorieEvent, CalorieState> {
  CalorieBloc() : super(CalorieState()) {
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
    on<SelectActivityLevel>((event, emit) {
      emit(state.copyWith(activityLevel: event.level));
    });

    on<CalculateTTDE>((event, emit) {
      final result = _calculateTDEE();
      if (result == null) return;

      emit(
        CalorieResultState(
          tdee: result,
          age: state.age,
          heightUnit: state.heightUnit,
          height1: state.height1,
          height2: state.height2,
          weightUnit: state.weightUnit,
          weight: state.weight,
          gender: state.gender,
          activityLevel: state.activityLevel,
        ),
      );
    });
  }

  double? _calculateTDEE() {
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

      // Tính BMR
      double bmr;
      if (state.gender == 'Nam') {
        bmr = 66.47 + (13.75 * weightKg) + (5.003 * heightCm) - (6.755 * age);
      } else {
        bmr = 655.1 + (9.563 * weightKg) + (1.850 * heightCm) - (4.676 * age);
      }

      // Tính TDEE
      final factor = state.activityLevel?.factor;
      if (factor == null) return null;

      final tdee = bmr * factor;

      return tdee;
    } catch (e, stack) {
      print('Lỗi tính TDEE: $e');
      print(stack);
      return null;
    }
  }
}
