import 'package:medicine_reminder/src/models/duration.dart';
import 'package:rxdart/rxdart.dart';
import './models/day.dart';

class GlobalBloc {
  BehaviorSubject<Day> _selectedDay$;
  BehaviorSubject<Day> get selectedDay$ => _selectedDay$.stream;

  BehaviorSubject<Period> _selectedPeriod$;
  BehaviorSubject<Period> get selectedPeriod$ => _selectedPeriod$.stream;

  GlobalBloc() {
    _selectedDay$ = BehaviorSubject<Day>.seeded(Day.Saturday);
    _selectedPeriod$ = BehaviorSubject<Period>.seeded(Period.Week);
  }

  void updateSelectedDay(Day day) {
    _selectedDay$.add(day);
  }

  void updateSelectedPeriod(Period period) {
    _selectedPeriod$.add(period);
  }

  void dispose() {
    _selectedDay$.close();
    _selectedPeriod$.close();
  }
}
