import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/mass/bloc/mass_event.dart';
import 'package:todo/screens/mass/bloc/mass_state.dart';

class MassBloc extends Bloc<MassEvent, MassState> {
  MassBloc() : super(MassState()) {
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

    on<SelectMassWay>((event, emit) {
      emit(state.copyWith(selected: event.selected));
    });

    on<CalculateBMI>((event, emit) {
      final result = _calculateBMI();
      if (result == null) return;
      final category = getBMICategory(result);

      emit(
        MassResultState(
          bmi: result,
          category: category,
          age: state.age,
          heightUnit: state.heightUnit,
          height1: state.height1,
          height2: state.height2,
          weightUnit: state.weightUnit,
          weight: state.weight,
          selected: state.selected,
        ),
      );
    });
  }

  double? _calculateBMI() {
    try {
      final double weight = double.parse(state.weight);
      final bool isLbs = state.weightUnit.toLowerCase() == 'lbs';
      final double weightKg = isLbs ? weight * 0.453592 : weight;

      double heightM;
      if (state.heightUnit.toLowerCase() == 'feet') {
        final double feet = double.tryParse(state.height1) ?? 0;
        final double inch = double.tryParse(state.height2) ?? 0;
        final double totalInch = feet * 12 + inch;
        heightM = totalInch * 0.0254;
      } else {
        final double cm = double.parse(state.height1);
        heightM = cm / 100;
      }

      if (heightM == 0) {
        return null;
      }

      final result =
          state.selected == MassWayType.standard
              ? weightKg / (heightM * heightM)
              : 1.3 * weightKg / pow(heightM, 2.5);

      print('[DEBUG] Kết quả BMI: $result');
      return result;
    } catch (e, stack) {
      print('Lỗi khi tính BMI: $e');
      print('Stack trace: $stack');
      return null;
    }
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Dưới cân nặng'; // Underweight
    } else if (bmi < 24.9) {
      return 'Cân nặng bình thường'; // Normal
    } else if (bmi < 29.9) {
      return 'Thừa cân'; // Overweight
    } else {
      return 'Cực kỳ béo phì'; // Obese
    }
  }
}
