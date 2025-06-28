import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final bool isDone;
  const Todo({required this.title, this.isDone = false});
  Todo toggle() {
    return Todo(title: title, isDone: !isDone);
  }

  @override
  List<Object?> get props => [title, isDone];
}
