import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/chest_hip/bloc/chest_hip_cubit.dart';
import 'package:todo/screens/chest_hip/bloc/chest_hip_state.dart';

void main() {
  group('ChestHipCubit', () {
    late ChestHipCubit cubit;

    setUp(() {
      cubit = ChestHipCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is ChestHipState', () {
      expect(cubit.state, const ChestHipState());
    });

    blocTest<ChestHipCubit, ChestHipState>(
      'emits state with updated gender',
      build: () => ChestHipCubit(),
      act: (cubit) => cubit.setGender(Gender.male),
      expect: () => [const ChestHipState(gender: Gender.male)],
    );

    blocTest<ChestHipCubit, ChestHipState>(
      'emits state with updated unit',
      build: () => ChestHipCubit(),
      act: (cubit) => cubit.setUnit(Unit.inch),
      expect: () => [const ChestHipState(unit: Unit.inch)],
    );

    blocTest<ChestHipCubit, ChestHipState>(
      'calculates ratio and level correctly with unit cm',
      build: () {
        final cubit = ChestHipCubit();
        cubit.setUnit(Unit.cm);
        return cubit;
      },
      act: (cubit) => cubit.calculateRatio(chestText: '95', hipText: '90'),
      expect:
          () => [
            isA<ChestHipState>()
                .having((s) => s.ratio, 'ratio', closeTo(1.0555, 0.01))
                .having(
                  (s) => s.level,
                  'level',
                  "Tam giác ngược (ngực to hơn hông)",
                ),
          ],
    );

    blocTest<ChestHipCubit, ChestHipState>(
      'calculates ratio and level correctly with unit inch',
      build: () {
        final cubit = ChestHipCubit();
        cubit.setUnit(Unit.inch);
        return cubit;
      },
      act: (cubit) => cubit.calculateRatio(chestText: '36', hipText: '38'),
      expect:
          () => [
            isA<ChestHipState>()
                .having(
                  (s) => s.ratio,
                  'ratio',
                  closeTo((36 * 2.54) / (38 * 2.54), 0.01),
                )
                .having((s) => s.level, 'level', "Hình quả lê (hông to hơn)"),
          ],
    );

    blocTest<ChestHipCubit, ChestHipState>(
      'emits null ratio and level when chest or hip is zero',
      build: () => ChestHipCubit(),
      act: (cubit) => cubit.calculateRatio(chestText: '0', hipText: '0'),
      expect: () => [const ChestHipState(ratio: null, level: null)],
    );
  });
}
