import 'package:flutter/material.dart';
import 'package:flutter_calendar/models/task.dart';
import 'package:flutter_calendar/providers/task_provider.dart';
import 'package:flutter_calendar/utils/utils.dart';
import 'package:flutter_calendar/widgets/add_task_form.dart';
import 'package:flutter_calendar/widgets/dismissible_item.dart';
import 'package:provider/provider.dart';

class DayDetailsScreen extends StatelessWidget {
  const DayDetailsScreen({Key? key, required this.day}) : super(key: key);

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    List<Task> tasksOfThisDay = context.watch<TaskProvider>().tasksOfDay(day);

    void saveForm(String title, String description, int hours, int minutes) {
      context.read<TaskProvider>().addTask(
            Task(
              title: title,
              description: description,
              dateTime: DateTime(day.year, day.month, day.day, hours, minutes),
            ),
          );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${day.day} ${Utils.monthName(day.month)} ${day.year}"),
      ),
      body: tasksOfThisDay.isEmpty
          ? Column(
              children: [
                const Text(
                  "You have no tasks for this day",
                  style: TextStyle(fontSize: 20),
                ),
                AddTaskForm(onFormSave: saveForm),
              ],
            )
          : ListView(
              children: List.generate(
                tasksOfThisDay.length,
                (index) => DismissibleItem(task: tasksOfThisDay[index]),
              )..add(AddTaskForm(onFormSave: saveForm)),
            ),
    );
  }
}
