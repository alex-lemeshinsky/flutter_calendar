import 'package:flutter/material.dart';
import 'package:flutter_calendar/models/task.dart';
import 'package:flutter_calendar/providers/calendar_state_provider.dart';
import 'package:flutter_calendar/providers/task_provider.dart';
import 'package:flutter_calendar/utils/utils.dart';
import 'package:flutter_calendar/widgets/calendar_tile.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentYear = context.watch<CalendarStateProvider>().currentYear;
    int currentMounth = context.watch<CalendarStateProvider>().currentMonth;

    context.read<TaskProvider>().init();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: context.read<CalendarStateProvider>().previousMonth,
                icon: const Icon(Icons.navigate_before),
              ),
              Text(
                "${Utils.monthName(currentMounth)} $currentYear",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              IconButton(
                onPressed: context.read<CalendarStateProvider>().nextMonth,
                icon: const Icon(Icons.navigate_next),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Table(
            border: TableBorder.symmetric(
              inside: const BorderSide(width: 1, color: Colors.grey),
            ),
            children: [
              TableRow(
                children: List.generate(
                  7,
                  (index) => Text(
                    Utils.daysOfWeek[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              ...List<TableRow>.generate(
                6,
                (indexOfRow) => TableRow(
                  children: List.generate(7, (indexOfCol) {
                    return CalendarTile(
                      currentMounth: currentMounth,
                      day: DateTime(
                        currentYear,
                        currentMounth - 1,
                        Utils.daysInMonth(
                              currentMounth - 1,
                              currentYear,
                            ) -
                            DateTime(
                              currentYear,
                              currentMounth,
                              1,
                            ).weekday +
                            2,
                      ).add(
                        Duration(days: indexOfRow * 7 + indexOfCol),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
