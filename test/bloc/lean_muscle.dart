import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/lean_muscle/bloc/lean_muscle_cubit.dart';
import 'package:todo/screens/lean_muscle/bloc/lean_muscle_state.dart';

void main() {
  group('LeanMuscleCubit', () {
    late LeanMuscleCubit cubit;

    setUp(() {
      cubit = LeanMuscleCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is LeanMuscleState', () {
      expect(cubit.state, const LeanMuscleState());
    });

    blocTest<LeanMuscleCubit, LeanMuscleState>(
      'sets gender to female',
      build: () => LeanMuscleCubit(),
      act: (cubit) => cubit.setGender(Gender.female),
      expect: () => [const LeanMuscleState(gender: Gender.female)],
    );

    blocTest<LeanMuscleCubit, LeanMuscleState>(
      'sets height unit to feetInch',
      build: () => LeanMuscleCubit(),
      act: (cubit) => cubit.setHeightUnit(HeightUnit.feetInch),
      expect: () => [const LeanMuscleState(heightUnit: HeightUnit.feetInch)],
    );

    blocTest<LeanMuscleCubit, LeanMuscleState>(
      'sets weight unit to lbs',
      build: () => LeanMuscleCubit(),
      act: (cubit) => cubit.setWeightUnit(WeightUnit.lbs),
      expect: () => [const LeanMuscleState(weightUnit: WeightUnit.lbs)],
    );

    blocTest<LeanMuscleCubit, LeanMuscleState>(
      'calculates lean muscle mass correctly for male, cm + kg',
      build: () => LeanMuscleCubit(),
      seed:
          () => LeanMuscleState(
            gender: Gender.male,
            heightUnit: HeightUnit.cm,
            weightUnit: WeightUnit.kg,
          ),
      act:
          (cubit) => cubit.calculateLeanMass(
            height1: '180',
            height2: '',
            weightText: '70',
          ),
      expect:
          () => [
            isA<LeanMuscleState>().having(
              (s) => s.leanMuscleMass,
              'leanMuscleMass',
              closeTo((0.407 * 70) + (0.267 * 180) - 19.2, 0.1),
            ),
          ],
    );

    blocTest<LeanMuscleCubit, LeanMuscleState>(
      'calculates lean muscle mass correctly for female, feet/inch + lbs',
      build: () => LeanMuscleCubit(),
      seed:
          () => LeanMuscleState(
            gender: Gender.female,
            heightUnit: HeightUnit.feetInch,
            weightUnit: WeightUnit.lbs,
          ),
      act:
          (cubit) => cubit.calculateLeanMass(
            height1: '5',
            height2: '4',
            weightText: '132', // ~59.87 kg
          ),
      expect:
          () => [
            isA<LeanMuscleState>().having(
              (s) => s.leanMuscleMass,
              'leanMuscleMass',
              closeTo((0.252 * 59.87) + (0.473 * 162.56) - 48.3, 0.1),
            ),
          ],
    );

    blocTest<LeanMuscleCubit, LeanMuscleState>(
      'does not calculate lean muscle mass if height or weight is invalid',
      build: () => LeanMuscleCubit(),
      act: (cubit) {
        cubit.setGender(Gender.male);
        cubit.setHeightUnit(HeightUnit.cm);
        cubit.setWeightUnit(WeightUnit.kg);
        cubit.calculateLeanMass(height1: '', height2: '', weightText: '');
      },
      expect:
          () => [
            isA<LeanMuscleState>().having(
              (s) => s.leanMuscleMass,
              'leanMuscleMass',
              null,
            ),
          ],
    );
  });
}
