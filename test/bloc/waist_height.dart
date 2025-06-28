import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/screens/waist_height/bloc/waist_height_cubit.dart';
import 'package:todo/screens/waist_height/bloc/waist_height_state.dart';

void main() {
  group('WaistHeightCubit', () {
    late WaistHeightCubit cubit;

    setUp(() {
      cubit = WaistHeightCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const WaistHeightState());
    });

    blocTest<WaistHeightCubit, WaistHeightState>(
      'sets gender to female',
      build: () => WaistHeightCubit(),
      act: (cubit) => cubit.setGender(Gender.female),
      expect: () => [const WaistHeightState(gender: Gender.female)],
    );

    blocTest<WaistHeightCubit, WaistHeightState>(
      'sets unit to inch',
      build: () => WaistHeightCubit(),
      act: (cubit) => cubit.setUnit(Unit.inch),
      expect: () => [const WaistHeightState(unit: Unit.inch)],
    );

    blocTest<WaistHeightCubit, WaistHeightState>(
      'sets height unit to feetInch',
      build: () => WaistHeightCubit(),
      act: (cubit) => cubit.setHeightUnit(HeightUnit.feetInch),
      expect: () => [const WaistHeightState(heightUnit: HeightUnit.feetInch)],
    );

    blocTest<WaistHeightCubit, WaistHeightState>(
      'calculates correct ratio and level with cm inputs',
      build: () => WaistHeightCubit(),
      seed:
          () => const WaistHeightState(
            unit: Unit.cm,
            heightUnit: HeightUnit.cm,
            gender: Gender.male,
            ratio: 0.5,
            level: "Bình thường",
          ),
      act:
          (cubit) => cubit.calculateRatio(
            waistText: '80',
            height1: '170',
            height2: '',
          ),
      expect:
          () => [
            isA<WaistHeightState>()
                .having((s) => s.ratio, 'ratio', closeTo(80 / 170, 0.001))
                .having((s) => s.level, 'level', 'Bình thường'),
          ],
    );

    blocTest<WaistHeightCubit, WaistHeightState>(
      'calculates correct ratio and level with inch inputs',
      build: () => WaistHeightCubit(),
      seed:
          () => const WaistHeightState(
            gender: Gender.female,
            unit: Unit.inch,
            heightUnit: HeightUnit.feetInch,
          ),
      act:
          (cubit) =>
              cubit.calculateRatio(waistText: '30', height1: '5', height2: '4'),
      expect: () {
        final height = ((5 * 12) + 4) * 2.54; // 162.56
        final waist = 30 * 2.54; // 76.2
        final ratio = waist / height;
        final level =
            ratio < 0.4
                ? "Gầy"
                : ratio < 0.5
                ? "Bình thường"
                : ratio < 0.6
                ? "Thừa mỡ"
                : "Nguy cơ cao";

        return [
          isA<WaistHeightState>()
              .having((s) => s.ratio, 'ratio', closeTo(ratio, 0.01))
              .having((s) => s.level, 'level', level),
        ];
      },
    );

    blocTest<WaistHeightCubit, WaistHeightState>(
      'emits null ratio and level when inputs are invalid',
      build: () => WaistHeightCubit(),
      seed:
          () => const WaistHeightState(
            unit: Unit.cm,
            heightUnit: HeightUnit.cm,
            gender: Gender.male,
            ratio: 0.5,
            level: 'Bình thường',
          ),
      act:
          (cubit) =>
              cubit.calculateRatio(waistText: '', height1: '', height2: ''),
      expect:
          () => [
            const WaistHeightState(
              unit: Unit.cm,
              heightUnit: HeightUnit.cm,
              gender: Gender.male,
              ratio: null,
              level: null,
            ),
          ],
    );
  });
}
