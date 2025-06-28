import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/calories_burned/bloc/calories_burned_event.dart';
import 'package:todo/screens/calories_burned/bloc/calories_burned_state.dart';

class CaloriesBurnedBloc
    extends Bloc<CaloriesBurnedEvent, CaloriesBurnedState> {
  CaloriesBurnedBloc() : super(CaloriesBurnedState()) {
    on<UpdateWeight>((event, emit) {
      emit(state.copyWith(weightUnit: event.unit, weight: event.value));
    });

    on<UpdateDistance>((event, emit) {
      emit(state.copyWith(distanceUnit: event.unit, distance: event.value));
    });
    on<UpdateExerciseType>((event, emit) {
      emit(state.copyWith(exerciseType: event.type));
    });
    on<SubmitCaloriesCalculation>((event, emit) {
      final weight = double.tryParse(event.weight);
      final distance = double.tryParse(event.distance);

      if (weight == null || weight <= 0) {
        return;
      }

      if (distance == null || distance <= 0) {
        return;
      }

      final isLbs = event.weightUnit.toLowerCase() == 'lbs';
      final isMile =
          event.distanceUnit.toLowerCase().contains('mile') ||
          event.distanceUnit == 'dặm';

      final weightKg = isLbs ? weight * 0.453592 : weight;
      final distanceKm = isMile ? distance * 1.60934 : distance;

      final caloriesPerKmPerKg = event.exerciseType == 'Chạy' ? 1.036 : 0.75;
      final calories = weightKg * distanceKm * caloriesPerKmPerKg;
      emit(
        CaloriesBurnedResultState(
          calories: calories,
          weight: event.weight,
          weightUnit: event.weightUnit,
          distance: event.distance,
          distanceUnit: event.distanceUnit,
          exerciseType: event.exerciseType,
        ),
      );
    });

    on<CalculateCalories>((event, emit) {
      final result = _calculateCalories();
      if (result != null) {
        emit(
          CaloriesBurnedResultState(
            calories: result,
            weight: state.weight,
            weightUnit: state.weightUnit,
            distance: state.distance,
            distanceUnit: state.distanceUnit,
            exerciseType: state.exerciseType,
          ),
        );
      }
    });
  }

  double? _calculateCalories() {
    final weightRaw = state.weight;
    final distanceRaw = state.distance;
    final unitWeight = state.weightUnit;
    final unitDistance = state.distanceUnit;
    final exercise = state.exerciseType;

    final weight = double.tryParse(weightRaw);
    final distance = double.tryParse(distanceRaw);

    if (weight == null || weight <= 0) {
      return null;
    }
    if (distance == null || distance <= 0) {
      return null;
    }

    final isLbs = unitWeight.toLowerCase() == 'lbs';
    final isMile =
        unitDistance.toLowerCase().contains('mile') || unitDistance == 'dặm';

    final weightKg = isLbs ? weight * 0.453592 : weight;
    final distanceKm = isMile ? distance * 1.60934 : distance;

    final caloriesPerKmPerKg = exercise == 'Chạy' ? 1.036 : 0.75;

    final result = weightKg * distanceKm * caloriesPerKmPerKg;
    return result;
  }
}
