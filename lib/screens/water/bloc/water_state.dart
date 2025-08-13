import 'package:equatable/equatable.dart';
import 'package:todo/screens/water/model/water_log.dart';

class WaterState extends Equatable {
  final int consumedAmount;
  final int remaining;
  final int total;
  final int selectedAmount;
  final double waveHeight;
  final List<WaterLog> todayLogs;

  const WaterState({
    required this.consumedAmount,
    required this.remaining,
    required this.total,
    required this.selectedAmount,
    required this.waveHeight,
    required this.todayLogs,
  });

  factory WaterState.initial() => WaterState(
    consumedAmount: 0,
    total: 3025,
    remaining: 3025,
    selectedAmount: 250,
    waveHeight: 0,
    todayLogs: [],
  );

  WaterState copyWith({
    int? consumedAmount,
    int? remaining,
    int? total,
    int? selectedAmount,
    double? waveHeight,
    List<WaterLog>? todayLogs,
  }) {
    return WaterState(
      consumedAmount: consumedAmount ?? this.consumedAmount,
      remaining: remaining ?? this.remaining,
      total: total ?? this.total,
      selectedAmount: selectedAmount ?? this.selectedAmount,
      waveHeight: waveHeight ?? this.waveHeight,
      todayLogs: todayLogs ?? this.todayLogs,
    );
  }

  @override
  List<Object?> get props => [
    total,
    consumedAmount,
    remaining,
    selectedAmount,
    waveHeight,
    todayLogs,
  ];
}
