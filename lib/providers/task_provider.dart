import 'package:flutter/material.dart';
import 'package:flutter_calendar/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskProvider extends ChangeNotifier {
  late List<Task> _tasks;
  final Box _box = Hive.box("taskBox");

  List<Task> get tasks => _tasks;

  List<Task> tasksOfDay(DateTime day) {
    return _tasks
        .where(
          (task) =>
              task.dateTime.year == day.year &&
              task.dateTime.month == day.month &&
              task.dateTime.day == day.day,
        )
        .toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  void addTask(Task task) {
    _box.add(task);
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task) async {
    await _box.deleteAt(_tasks.indexOf(task));
    _tasks.remove(task);
    notifyListeners();
  }

  void init() {
    // need to map every item because by default elements are dynamic
    _tasks = _box.values
        .map(
          (e) => Task(
            title: e.title,
            description: e.description,
            dateTime: e.dateTime,
          ),
        )
        .toList();
  }
}
