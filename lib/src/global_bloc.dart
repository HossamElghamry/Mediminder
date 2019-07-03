import 'dart:convert';
import 'package:medicine_reminder/src/models/medicine.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc {
  // BehaviorSubject<Day> _selectedDay$;
  // BehaviorSubject<Day> get selectedDay$ => _selectedDay$.stream;

  // BehaviorSubject<Period> _selectedPeriod$;
  // BehaviorSubject<Period> get selectedPeriod$ => _selectedPeriod$.stream;

  BehaviorSubject<List<Medicine>> _medicineList$;
  BehaviorSubject<List<Medicine>> get medicineList$ => _medicineList$;

  GlobalBloc() {
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    makeMedicineList();
    // _selectedDay$ = BehaviorSubject<Day>.seeded(Day.Saturday);
    // _selectedPeriod$ = BehaviorSubject<Period>.seeded(Period.Week);
  }

  // void updateSelectedDay(Day day) {
  //   _selectedDay$.add(day);
  // }

  // void updateSelectedPeriod(Period period) {
  //   _selectedPeriod$.add(period);
  // }

  Future removeMedicine(Medicine tobeRemoved) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> medicineJsonList = [];

    var blocList = _medicineList$.value;
    blocList.removeWhere(
        (medicine) => medicine.medicineName == tobeRemoved.medicineName);

    for (int i = 0; i < (24 / tobeRemoved.interval).floor(); i++) {
      flutterLocalNotificationsPlugin
          .cancel(int.parse(tobeRemoved.notificationIDs[i]));
    }
    if (blocList.length != 0) {
      for (var blocMedicine in blocList) {
        String medicineJson = jsonEncode(blocMedicine.toJson());
        medicineJsonList.add(medicineJson);
      }
    }
    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$.add(blocList);
  }

  Future updateMedicineList(Medicine newMedicine) async {
    var blocList = _medicineList$.value;
    blocList.add(newMedicine);
    _medicineList$.add(blocList);
    Map<String, dynamic> tempMap = newMedicine.toJson();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if (sharedUser.getStringList('medicines') == null) {
      medicineJsonList.add(newMedicineJson);
    } else {
      medicineJsonList = sharedUser.getStringList('medicines');
      medicineJsonList.add(newMedicineJson);
    }
    sharedUser.setStringList('medicines', medicineJsonList);
  }

  Future makeMedicineList() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('medicines');
    List<Medicine> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        Map userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      _medicineList$.add(prefList);
    }
  }

  void dispose() {
    // _selectedDay$.close();
    // _selectedPeriod$.close();
    _medicineList$.close();
  }
}
