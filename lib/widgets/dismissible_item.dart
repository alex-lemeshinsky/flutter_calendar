import 'package:flutter/material.dart';
import 'package:flutter_calendar/models/task.dart';
import 'package:flutter_calendar/providers/task_provider.dart';
import 'package:provider/provider.dart';

class DismissibleItem extends StatelessWidget {
  const DismissibleItem({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.hashCode.toString()),
      onDismissed: (direction) => context.read<TaskProvider>().deleteTask(task),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: ListTile(
          title: Text(task.title),
          subtitle: Text(
              "${task.description}\nAt ${task.dateTime.hour}:${task.dateTime.minute == 0 ? "00" : "30"}"),
          isThreeLine: true,
        ),
      ),
    );
  }
}
