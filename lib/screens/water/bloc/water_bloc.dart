import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/water/bloc/water_event.dart';
import 'package:todo/screens/water/bloc/water_state.dart';
import 'package:todo/screens/water/model/water_log.dart';

class WaterBloc extends Bloc<WaterEvent, WaterState> {
  static const double maxWaveHeight = 1000.0;
  WaterBloc() : super(WaterState.initial()) {
    on<LoadInitialAmount>(_onLoadInitialAmount);
    on<AddWater>(_onAddWater);
    on<SelectAmount>(_onSelectAmount);
    on<LoadTodayLogs>(_onLoadTodayLogs);
    on<ClearAllLogs>(_onClearAllLogs);
    on<DeleteLogAtIndex>(_onDeleteLogAtIndex);
  }

  Future<void> _onLoadInitialAmount(
    LoadInitialAmount event,
    Emitter<WaterState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final selected = prefs.getInt('selected_water_amount') ?? 250;

    final logs = prefs.getStringList('water_logs') ?? [];
    int totalConsumed = 0;

    for (final logStr in logs) {
      final map = jsonDecode(logStr);
      totalConsumed += map['added'] as int;
    }

    final remaining = (state.total - totalConsumed).clamp(0, state.total);
    final percent = totalConsumed / state.total;
    final waveHeight = percent.clamp(0.0, 1.0) * WaterBloc.maxWaveHeight;
    emit(
      state.copyWith(
        selectedAmount: selected,
        consumedAmount: totalConsumed,
        remaining: remaining,
        waveHeight: waveHeight,
      ),
    );
    add(LoadTodayLogs());
  }

  void _onAddWater(AddWater event, Emitter<WaterState> emit) async {
    final newConsumed = state.consumedAmount + event.amount;
    final newRemaining = (state.total - newConsumed).clamp(0, state.total);
    final percent = newConsumed / state.total;
    final waveHeight = percent.clamp(0.0, 1.0) * WaterBloc.maxWaveHeight;
    // Lưu thông tin vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();
    // Tạo list mới hoặc lấy list cũ
    final existingLogs = prefs.getStringList('water_logs') ?? [];
    // Ghi log mới dưới dạng JSON
    final newLog = {
      'time': now,
      'added': event.amount,
      'consumed': newConsumed,
    };
    // existingLogs.add(newLog.toString());
    existingLogs.add(jsonEncode(newLog));
    // Lưu lại toàn bộ log
    await prefs.setStringList('water_logs', existingLogs);
    print('Đã lưu water_logs:');
    for (final log in existingLogs) {
      print(log);
    }
    emit(
      state.copyWith(
        consumedAmount: newConsumed,
        remaining: newRemaining,
        waveHeight: waveHeight,
      ),
    );
    add(LoadTodayLogs());
  }

  void _onSelectAmount(SelectAmount event, Emitter<WaterState> emit) {
    emit(state.copyWith(selectedAmount: event.amount));
  }

  Future<void> _onClearAllLogs(
    ClearAllLogs event,
    Emitter<WaterState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('water_logs');
    await prefs.remove('selected_water_amount');

    emit(WaterState.initial());
  }

  Future<void> _onLoadTodayLogs(
    LoadTodayLogs event,
    Emitter<WaterState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final logs = prefs.getStringList('water_logs') ?? [];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final todayLogs = <WaterLog>[];
    int totalConsumed = 0;

    for (int i = 0; i < logs.length; i++) {
      final map = jsonDecode(logs[i]);
      final logTime = DateTime.parse(map['time']);
      if (logTime.year == today.year &&
          logTime.month == today.month &&
          logTime.day == today.day) {
        final formatted = DateFormat('hh:mm a').format(logTime);
        final added = map['added'] as int;
        totalConsumed += added;

        todayLogs.add(
          WaterLog(
            time: logTime,
            timeFormatted: formatted,
            amount: added,
            originalIndex: i,
          ),
        );
      }
    }

    final remaining = (state.total - totalConsumed).clamp(0, state.total);
    final percent = totalConsumed / state.total;
    final waveHeight = percent.clamp(0.0, 1.0) * WaterBloc.maxWaveHeight;

    emit(
      state.copyWith(
        todayLogs: todayLogs,
        consumedAmount: totalConsumed,
        remaining: remaining,
        waveHeight: waveHeight,
      ),
    );
  }

  Future<void> _onDeleteLogAtIndex(
    DeleteLogAtIndex event,
    Emitter<WaterState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final logs = prefs.getStringList('water_logs') ?? [];

    // Kiểm tra index hợp lệ
    if (event.index < 0 || event.index >= logs.length) return;

    logs.removeAt(event.index);

    await prefs.setStringList('water_logs', logs);

    // Cập nhật lại trạng thái
    add(LoadTodayLogs());
  }
}
