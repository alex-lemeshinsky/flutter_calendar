import 'package:flutter/material.dart';
import 'package:flutter_calendar/models/task.dart';
import 'package:flutter_calendar/providers/calendar_state_provider.dart';
import 'package:flutter_calendar/providers/task_provider.dart';
import 'package:flutter_calendar/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox("taskBox");
  runApp(const FlutterCalendar());
}

class FlutterCalendar extends StatelessWidget {
  const FlutterCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => CalendarStateProvider()),
      ],
      child: const MaterialApp(
        title: "Calendar app",
        home: HomeScreen(),
      ),
    );
  }
}
