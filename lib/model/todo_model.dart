import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  int? taskId;

  @HiveField(1)
  final String taskName;

  @HiveField(2)
  final String taskSubTitle;

  TodoModel({
    this.taskId,
    required this.taskName,
    required this.taskSubTitle,
  });
}
