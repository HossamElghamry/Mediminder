import 'package:flutter/material.dart';
import 'package:medicine_reminder/src/common/covert_minute.dart';
import 'package:medicine_reminder/src/models/day.dart';
import 'package:medicine_reminder/src/models/medicine_type.dart';
import 'package:medicine_reminder/src/ui/homepage/new_entry_bloc.dart';
import 'package:provider/provider.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  TextEditingController nameController = TextEditingController();

  TextEditingController dosageController = TextEditingController();

  void dispose() {
    nameController.dispose();
    dosageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewEntryBloc _newEntryBloc = NewEntryBloc();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF3EB16F), //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Add New Reminder",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
          child: Provider<NewEntryBloc>.value(
        value: _newEntryBloc,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          children: <Widget>[
            PanelTitle(
              title: "Medicine Name",
              isRequired: true,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: 16,
              ),
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            PanelTitle(
              title: "Dosage in mg",
              isRequired: true,
            ),
            TextFormField(
              controller: dosageController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16,
              ),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            PanelTitle(
              title: "Medicine Type",
              isRequired: false,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: StreamBuilder<MedicineType>(
                  stream: _newEntryBloc.selectedMedicineType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MedicineTypeColumn(
                            type: MedicineType.Bottle,
                            name: "Bottle",
                            iconValue: 0xe900,
                            isSelected: snapshot.data == MedicineType.Bottle
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Pill,
                            name: "Pill",
                            iconValue: 0xe901,
                            isSelected: snapshot.data == MedicineType.Pill
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Syringe,
                            name: "Syringe",
                            iconValue: 0xe902,
                            isSelected: snapshot.data == MedicineType.Syringe
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Tablet,
                            name: "Tablet",
                            iconValue: 0xe903,
                            isSelected: snapshot.data == MedicineType.Tablet
                                ? true
                                : false),
                      ],
                    );
                  }),
            ),
            PanelTitle(
              title: "Interval Selection",
              isRequired: true,
            ),
            //ScheduleCheckBoxes(),
            IntervalSelection(),
            PanelTitle(
              title: "Starting Time",
              isRequired: true,
            ),
            SelectTime(),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.08,
                right: MediaQuery.of(context).size.height * 0.08,
              ),
              child: Container(
                width: 220,
                height: 70,
                child: FlatButton(
                  color: Color(0xFF3EB16F),
                  shape: StadiumBorder(),
                  onPressed: () {
                    print(nameController.value);
                    print(dosageController.value);
                    print(_newEntryBloc.selectedMedicineType.value);
                    print(_newEntryBloc.selectedInterval$.value);
                    print(_newEntryBloc.selectedTimeOfDay$.value);
                  },
                  child: Center(
                    child: Text(
                      "CONFIRM",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  @override
  _IntervalSelectionState createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  var _intervals = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24
  ];
  var _selected = 1;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Remind me every  ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<int>(
              elevation: 4,
              value: _selected,
              items: _intervals.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _selected = newVal;
                  _newEntryBloc.updateInterval(newVal);
                });
              },
            ),
            Text(
              _selected == 1 ? " hour" : " hours",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        _newEntryBloc.updateTime(
            ["${_time.hour}", "${convertToMinutes(_time.minute.toString())}"]);
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 4),
            child: FlatButton(
              color: Color(0xFF3EB16F),
              shape: StadiumBorder(),
              onPressed: () {
                _selectTime(context);
              },
              child: Center(
                child: Text(
                  _clicked == false ? "Pick Time" : "Edit Time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              _clicked == false
                  ? ""
                  : "Selected starting time: ${_time.hour}:${convertToMinutes(_time.minute.toString())}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  final MedicineType type;
  final String name;
  final int iconValue;
  final bool isSelected;

  MedicineTypeColumn(
      {Key key,
      @required this.type,
      @required this.name,
      @required this.iconValue,
      @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        _newEntryBloc.updateSelectedMedicine(type);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? Color(0xFF3EB16F) : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Icon(
                  IconData(iconValue, fontFamily: "Ic"),
                  size: 75,
                  color: isSelected ? Colors.white : Color(0xFF3EB16F),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF3EB16F) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Color(0xFF3EB16F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ScheduleCheckBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return StreamBuilder<List<Day>>(
        stream: _newEntryBloc.checkedDays$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    BuildDay(
                      text: "Sat",
                      day: Day.Saturday,
                      isSelected:
                          snapshot.data.contains(Day.Saturday) ? true : false,
                    ),
                    BuildDay(
                      text: "Sun",
                      day: Day.Sunday,
                      isSelected:
                          snapshot.data.contains(Day.Sunday) ? true : false,
                    ),
                    BuildDay(
                      text: "Mon",
                      day: Day.Monday,
                      isSelected:
                          snapshot.data.contains(Day.Monday) ? true : false,
                    ),
                    BuildDay(
                      text: "Tue",
                      day: Day.Tuesday,
                      isSelected:
                          snapshot.data.contains(Day.Tuesday) ? true : false,
                    ),
                    BuildDay(
                      text: "Wed",
                      day: Day.Wednesday,
                      isSelected:
                          snapshot.data.contains(Day.Wednesday) ? true : false,
                    ),
                    BuildDay(
                      text: "Thu",
                      day: Day.Thursday,
                      isSelected:
                          snapshot.data.contains(Day.Thursday) ? true : false,
                    ),
                    BuildDay(
                      text: "Fri",
                      day: Day.Friday,
                      isSelected:
                          snapshot.data.contains(Day.Friday) ? true : false,
                    ),
                  ]),
            );
          }
        });
  }
}

class BuildDay extends StatelessWidget {
  final String text;
  final Day day;
  final bool isSelected;

  BuildDay(
      {Key key,
      @required this.text,
      @required this.day,
      @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: Color(0xFF3EB16F),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Checkbox(
          value: isSelected,
          activeColor: Color(0xFF3EB16F),
          onChanged: (value) {
            _newEntryBloc.addtoDays(day);
          },
        ),
      ],
    );
    ;
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Color(0xFF3EB16F)),
          ),
        ]),
      ),
    );
  }
}
