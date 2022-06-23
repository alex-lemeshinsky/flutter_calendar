import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? description;

  @HiveField(3)
  final DateTime dateTime;

  Task({
    required this.title,
    required this.description,
    required this.dateTime,
  });
}
