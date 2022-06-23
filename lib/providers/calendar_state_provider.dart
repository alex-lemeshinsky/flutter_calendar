import 'package:flutter/material.dart';

class CalendarStateProvider extends ChangeNotifier {
  int _currentYear = DateTime.now().year;
  int _currentMonth = DateTime.now().month;

  int get currentYear => _currentYear;
  int get currentMonth => _currentMonth;

  void nextMonth() {
    if (_currentMonth == 12) {
      _currentYear += 1;
      _currentMonth = 1;
    } else {
      _currentMonth += 1;
    }

    notifyListeners();
  }

  void previousMonth() {
    if (_currentMonth == 1) {
      _currentYear -= 1;
      _currentMonth = 12;
    } else {
      _currentMonth -= 1;
    }

    notifyListeners();
  }
}
