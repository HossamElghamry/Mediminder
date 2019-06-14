import 'package:medicine_reminder/src/models/day.dart';
import 'package:medicine_reminder/src/models/medicine_type.dart';
import 'package:rxdart/rxdart.dart';

class NewEntryBloc {
  BehaviorSubject<MedicineType> _selectedMedicineType$;
  BehaviorSubject<MedicineType> get selectedMedicineType =>
      _selectedMedicineType$.stream;

  BehaviorSubject<List<Day>> _checkedDays$;
  BehaviorSubject<List<Day>> get checkedDays$ => _checkedDays$;

  NewEntryBloc() {
    _selectedMedicineType$ =
        BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
  }

  void dispose() {
    _selectedMedicineType$.close();
    _checkedDays$.close();
  }

  void addtoDays(Day day) {
    List<Day> _updatedDayList = _checkedDays$.value;
    if (_updatedDayList.contains(day)) {
      _updatedDayList.remove(day);
    } else {
      _updatedDayList.add(day);
    }
    _checkedDays$.add(_updatedDayList);
  }

  void updateSelectedMedicine(MedicineType type) {
    MedicineType _tempType = _selectedMedicineType$.value;
    if (type == _tempType) {
      _selectedMedicineType$.add(MedicineType.None);
    } else {
      _selectedMedicineType$.add(type);
    }
  }
}
