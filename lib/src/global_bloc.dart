import 'dart:convert';

import 'package:medicine_reminder/src/models/duration.dart';
import 'package:medicine_reminder/src/models/medicine.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/day.dart';

class GlobalBloc {
  BehaviorSubject<Day> _selectedDay$;
  BehaviorSubject<Day> get selectedDay$ => _selectedDay$.stream;

  BehaviorSubject<Period> _selectedPeriod$;
  BehaviorSubject<Period> get selectedPeriod$ => _selectedPeriod$.stream;

  BehaviorSubject<Medicine> _medicineList$;
  BehaviorSubject<Medicine> get medicineList$ => _medicineList$;

  GlobalBloc() {
    makeMedicineList();
    _selectedDay$ = BehaviorSubject<Day>.seeded(Day.Saturday);
    _selectedPeriod$ = BehaviorSubject<Period>.seeded(Period.Week);
    _medicineList$ = BehaviorSubject<Medicine>.seeded(null);
  }

  void updateSelectedDay(Day day) {
    _selectedDay$.add(day);
  }

  void updateSelectedPeriod(Period period) {
    _selectedPeriod$.add(period);
  }

  void updateMedicineList(Medicine newMedicine) {
    _medicineList$.add(newMedicine);
  }

  Future makeMedicineList() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String stringJSON = sharedUser.getString('medicine');
    if (stringJSON == null) {
      return;
    } else {
      Map userMap = jsonDecode(stringJSON);
      Medicine newList = Medicine.fromJson(userMap);
      _medicineList$.add(newList);
    }
  }

  void dispose() {
    _selectedDay$.close();
    _selectedPeriod$.close();
  }
}
