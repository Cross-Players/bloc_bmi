import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/calories_burned/bloc/calories_burned_bloc.dart';
import 'package:todo/screens/calories_burned/bloc/calories_burned_event.dart';
import 'package:todo/screens/calories_burned/bloc/calories_burned_state.dart';

void main() {
  group('CaloriesBurnedBloc', () {
    late CaloriesBurnedBloc bloc;

    setUp(() {
      bloc = CaloriesBurnedBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is CaloriesBurnedState', () {
      expect(bloc.state, isA<CaloriesBurnedState>());
    });

    blocTest<CaloriesBurnedBloc, CaloriesBurnedState>(
      'emits updated weight',
      build: () => CaloriesBurnedBloc(),
      act: (bloc) => bloc.add(UpdateWeight(unit: 'kg', value: '60')),
      expect:
          () => [
            isA<CaloriesBurnedState>()
                .having((s) => s.weight, 'weight', '60')
                .having((s) => s.weightUnit, 'weightUnit', 'kg'),
          ],
    );

    blocTest<CaloriesBurnedBloc, CaloriesBurnedState>(
      'emits updated distance',
      build: () => CaloriesBurnedBloc(),
      act: (bloc) => bloc.add(UpdateDistance(unit: 'km', value: '5')),
      expect:
          () => [
            isA<CaloriesBurnedState>()
                .having((s) => s.distance, 'distance', '5')
                .having((s) => s.distanceUnit, 'distanceUnit', 'km'),
          ],
    );

    blocTest<CaloriesBurnedBloc, CaloriesBurnedState>(
      'emits updated exerciseType',
      build: () => CaloriesBurnedBloc(),
      act: (bloc) => bloc.add(UpdateExerciseType('Đi bộ')),
      expect:
          () => [
            isA<CaloriesBurnedState>().having(
              (s) => s.exerciseType,
              'exerciseType',
              'Đi bộ',
            ),
          ],
    );

    blocTest<CaloriesBurnedBloc, CaloriesBurnedState>(
      'emits CaloriesBurnedResultState when SubmitCaloriesCalculation is added (Chạy)',
      build: () => CaloriesBurnedBloc(),
      act:
          (bloc) => bloc.add(
            SubmitCaloriesCalculation(
              weight: '60',
              weightUnit: 'kg',
              distance: '5',
              distanceUnit: 'km',
              exerciseType: 'Chạy',
            ),
          ),
      expect:
          () => [
            isA<CaloriesBurnedResultState>()
                .having((s) => s.calories, 'calories', closeTo(310.8, 0.1))
                .having((s) => s.exerciseType, 'exerciseType', 'Chạy'),
          ],
    );

    blocTest<CaloriesBurnedBloc, CaloriesBurnedState>(
      'emits CaloriesBurnedResultState when CalculateCalories is added (Đi bộ)',
      build: () => CaloriesBurnedBloc(),
      seed:
          () => CaloriesBurnedState(
            weight: '60',
            weightUnit: 'kg',
            distance: '4',
            distanceUnit: 'km',
            exerciseType: 'Đi bộ',
          ),
      act: (bloc) => bloc.add(CalculateCalories()),
      expect:
          () => [
            isA<CaloriesBurnedResultState>()
                .having((s) => s.calories, 'calories', closeTo(180.0, 0.1))
                .having((s) => s.exerciseType, 'exerciseType', 'Đi bộ'),
          ],
    );

    blocTest<CaloriesBurnedBloc, CaloriesBurnedState>(
      'does not emit when invalid weight or distance',
      build: () => CaloriesBurnedBloc(),
      act:
          (bloc) => bloc.add(
            SubmitCaloriesCalculation(
              weight: '0',
              weightUnit: 'kg',
              distance: '',
              distanceUnit: 'km',
              exerciseType: 'Chạy',
            ),
          ),
      expect: () => [], // Không emit gì nếu input sai
    );
  });
}
