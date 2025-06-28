import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/ideal_weight/bloc/ideal_weight_cubit.dart';
import 'package:todo/screens/ideal_weight/bloc/ideal_weight_state.dart';

void main() {
  group('IdealWeightCubit', () {
    late IdealWeightCubit cubit;

    setUp(() {
      cubit = IdealWeightCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state has male and light frame', () {
      expect(cubit.state.gender, Gender.male);
      expect(cubit.state.frame, BodyFrame.light);
      expect(cubit.state.height, null);
      expect(cubit.state.idealWeight, null);
    });

    blocTest<IdealWeightCubit, IdealWeightState>(
      'sets gender to female',
      build: () => IdealWeightCubit(),
      act: (cubit) => cubit.setGender(Gender.female),
      expect:
          () => [
            isA<IdealWeightState>().having(
              (s) => s.gender,
              'gender',
              Gender.female,
            ),
          ],
    );

    blocTest<IdealWeightCubit, IdealWeightState>(
      'sets frame to heavy',
      build: () => IdealWeightCubit(),
      act: (cubit) => cubit.setFrame(BodyFrame.heavy),
      expect:
          () => [
            isA<IdealWeightState>().having(
              (s) => s.frame,
              'frame',
              BodyFrame.heavy,
            ),
          ],
    );

    blocTest<IdealWeightCubit, IdealWeightState>(
      'calculates ideal weight from 170cm using seed',
      build: () => IdealWeightCubit(),
      seed:
          () => IdealWeightState(
            gender: Gender.male,
            frame: BodyFrame.light,
            height: 170,
            heightUnit: HeightUnit.cm,
          ),
      act: (cubit) => cubit.calculate(),
      expect:
          () => [
            isA<IdealWeightState>().having(
              (s) => s.idealWeight,
              'idealWeight',
              closeTo(63.0, 0.1),
            ),
          ],
    );

    blocTest<IdealWeightCubit, IdealWeightState>(
      'calculates ideal weight from 5ft 7in (170.18cm), female, medium frame',
      build: () => IdealWeightCubit(),
      seed:
          () => IdealWeightState(
            gender: Gender.female,
            frame: BodyFrame.medium,
            height: 170.18,
            heightUnit: HeightUnit.feetInch,
          ),
      act: (cubit) => cubit.calculate(),
      expect:
          () => [
            isA<IdealWeightState>().having(
              (s) => s.idealWeight,
              'idealWeight',
              closeTo(65.18, 0.1),
            ),
          ],
    );

    blocTest<IdealWeightCubit, IdealWeightState>(
      'calculateFromInput parses height1 and height2 correctly in feet using seed',
      build: () => IdealWeightCubit(),
      seed:
          () => IdealWeightState(
            gender: Gender.male,
            frame: BodyFrame.heavy,
            heightUnit: HeightUnit.feetInch,
          ),
      act: (cubit) => cubit.calculateFromInput(height1: '5', height2: '10'),
      wait: const Duration(milliseconds: 10),
      expect:
          () => [
            isA<IdealWeightState>().having(
              (s) => s.height,
              'height',
              closeTo(177.8, 0.1),
            ),
            isA<IdealWeightState>().having(
              (s) => s.idealWeight,
              'idealWeight',
              closeTo((177.8 - 100) * 1.1, 0.1),
            ),
          ],
    );

    blocTest<IdealWeightCubit, IdealWeightState>(
      'calculateFromInput with cm input using seed',
      build: () => IdealWeightCubit(),
      seed:
          () => IdealWeightState(
            gender: Gender.female,
            frame: BodyFrame.light,
            heightUnit: HeightUnit.cm,
          ),
      act: (cubit) => cubit.calculateFromInput(height1: '160', height2: ''),
      wait: const Duration(milliseconds: 10),
      expect:
          () => [
            isA<IdealWeightState>().having((s) => s.height, 'height', 160),
            isA<IdealWeightState>().having(
              (s) => s.idealWeight,
              'idealWeight',
              closeTo((160 - 105) * 0.9, 0.1),
            ),
          ],
    );
  });
}
