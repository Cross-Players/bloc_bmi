import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:todo/screens/water/bloc/water_bloc.dart';
import 'package:todo/screens/water/bloc/water_event.dart';
import 'package:todo/screens/water/bloc/water_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WaterBloc', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    blocTest<WaterBloc, WaterState>(
      'emits correct state on LoadInitialAmount',
      build: () {
        final now = DateTime.now().toIso8601String();
        final logs = [
          jsonEncode({'time': now, 'added': 300, 'consumed': 300}),
          jsonEncode({'time': now, 'added': 200, 'consumed': 500}),
        ];
        prefs.setStringList('water_logs', logs);
        prefs.setInt('selected_water_amount', 500);
        return WaterBloc();
      },
      act: (bloc) => bloc.add(LoadInitialAmount()),
      wait: const Duration(milliseconds: 500),
      verify: (bloc) {
        expect(bloc.state.selectedAmount, 500);
        expect(bloc.state.consumedAmount, 500);
        expect(bloc.state.remaining, bloc.state.total - 500);
      },
    );

    blocTest<WaterBloc, WaterState>(
      'adds water and updates logs & state',
      build: () => WaterBloc(),
      act: (bloc) => bloc.add(AddWater(250)),
      wait: const Duration(milliseconds: 500),
      verify: (bloc) {
        expect(bloc.state.consumedAmount, 250);
        expect(bloc.state.remaining, bloc.state.total - 250);
      },
    );

    blocTest<WaterBloc, WaterState>(
      'updates selected amount',
      build: () => WaterBloc(),
      act: (bloc) => bloc.add(SelectAmount(500)),
      expect:
          () => [
            isA<WaterState>().having(
              (s) => s.selectedAmount,
              'selectedAmount',
              500,
            ),
          ],
    );

    blocTest<WaterBloc, WaterState>(
      'clears all logs and resets state',
      build: () {
        prefs.setStringList('water_logs', [
          '{"time":"2025-06-28T12:00:00","added":300,"consumed":300}',
        ]);
        prefs.setInt('selected_water_amount', 250);
        return WaterBloc();
      },
      act: (bloc) => bloc.add(ClearAllLogs()),
      wait: const Duration(milliseconds: 500),
      verify: (_) async {
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getStringList('water_logs'), null);
        expect(prefs.getInt('selected_water_amount'), null);
      },
    );

    blocTest<WaterBloc, WaterState>(
      'deletes specific log and reloads today logs',
      build: () {
        final today = DateTime.now().toIso8601String();
        prefs.setStringList('water_logs', [
          jsonEncode({'time': today, 'added': 300, 'consumed': 300}),
          jsonEncode({'time': today, 'added': 200, 'consumed': 500}),
        ]);
        return WaterBloc();
      },
      act: (bloc) => bloc.add(DeleteLogAtIndex(0)),
      wait: const Duration(milliseconds: 500),
      verify: (_) async {
        final logs = prefs.getStringList('water_logs')!;
        expect(logs.length, 1);
        final remainingLog = jsonDecode(logs.first);
        expect(remainingLog['added'], 200);
      },
    );
  });
}
