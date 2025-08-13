abstract class WaterEvent {}

class AddWater extends WaterEvent {
  final int amount;
  AddWater(this.amount);
}

class SelectAmount extends WaterEvent {
  final int amount;
  SelectAmount(this.amount);
}

class LoadInitialAmount extends WaterEvent {}

class LoadTodayLogs extends WaterEvent {}

class ClearAllLogs extends WaterEvent {}

class DeleteLogAtIndex extends WaterEvent {
  final int index;
  DeleteLogAtIndex(this.index);
}
