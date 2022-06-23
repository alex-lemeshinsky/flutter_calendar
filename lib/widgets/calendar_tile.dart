import 'package:flutter/material.dart';
import 'package:flutter_calendar/providers/task_provider.dart';
import 'package:flutter_calendar/screens/day_screen.dart';
import 'package:provider/provider.dart';

class CalendarTile extends StatelessWidget {
  const CalendarTile({Key? key, required this.day, required this.currentMounth})
      : super(key: key);

  final DateTime day;
  final int currentMounth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DayDetailsScreen(day: day)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 70,
        child: Stack(
          children: [
            Text(
              day.day.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: day.month == currentMounth ? Colors.black : Colors.grey,
              ),
            ),
            if (context.watch<TaskProvider>().tasksOfDay(day).isNotEmpty)
              Positioned(
                bottom: 0,
                right: 0,
                child: ClipOval(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.blue),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      context
                          .watch<TaskProvider>()
                          .tasksOfDay(day)
                          .length
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
