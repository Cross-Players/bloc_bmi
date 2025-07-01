import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/screens/waist_hip/bloc/waist_hip_cubit.dart';
import 'package:todo/screens/waist_hip/bloc/waist_hip_state.dart';

void main() {
  group('WaistHipCubit', () {
    late WaistHipCubit cubit;

    setUp(() {
      cubit = WaistHipCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const WaistHipState());
    });

    blocTest<WaistHipCubit, WaistHipState>(
      'emits updated unit',
      build: () => WaistHipCubit(),
      act: (cubit) => cubit.setUnit(Unit.inch),
      expect: () => [const WaistHipState(unit: Unit.inch)],
    );

    blocTest<WaistHipCubit, WaistHipState>(
      'emits updated gender',
      build: () => WaistHipCubit(),
      act: (cubit) => cubit.setGender(Gender.female),
      expect: () => [const WaistHipState(gender: Gender.female)],
    );

    blocTest<WaistHipCubit, WaistHipState>(
      'calculates correct ratio and level for male (cm)',
      build: () => WaistHipCubit(),
      seed: () => const WaistHipState(gender: Gender.male, unit: Unit.cm),
      act: (cubit) => cubit.calculateRatio(waistText: '90', hipText: '100'),
      expect:
          () => [
            isA<WaistHipState>()
                .having((s) => s.ratio, 'ratio', closeTo(0.9, 0.001))
                .having((s) => s.level, 'level', 'Nguy cơ cao'),
          ],
    );

    blocTest<WaistHipCubit, WaistHipState>(
      'calculates correct ratio and level for female (inch)',
      build: () => WaistHipCubit(),
      seed: () => const WaistHipState(gender: Gender.female, unit: Unit.inch),
      act: (cubit) => cubit.calculateRatio(waistText: '34', hipText: '40'),
      expect: () {
        final waistCm = 34 * 2.54;
        final hipCm = 40 * 2.54;
        final ratio = waistCm / hipCm;
        final level = ratio >= 0.85 ? 'Nguy cơ cao' : 'Bình thường';
        return [
          isA<WaistHipState>()
              .having((s) => s.ratio, 'ratio', closeTo(ratio, 0.001))
              .having((s) => s.level, 'level', level),
        ];
      },
    );

    blocTest<WaistHipCubit, WaistHipState>(
      'emits null ratio and level when input is invalid',
      build: () => WaistHipCubit(),
      seed:
          () => const WaistHipState(
            gender: Gender.male,
            unit: Unit.cm,
            ratio: 0.8,
            level: 'Bình thường',
          ),
      act: (cubit) => cubit.calculateRatio(waistText: '', hipText: ''),
      expect:
          () => [
            const WaistHipState(
              gender: Gender.male,
              unit: Unit.cm,
              ratio: null,
              level: null,
            ),
          ],
    );
  });
}
