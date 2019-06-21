import 'package:flutter/material.dart';
import 'package:medicine_reminder/src/global_bloc.dart';
import 'package:medicine_reminder/src/models/day.dart';
import 'package:medicine_reminder/src/models/duration.dart';
import 'package:medicine_reminder/src/models/medicine.dart';
import 'package:medicine_reminder/src/models/medicine_type.dart';
import 'package:medicine_reminder/src/ui/homepage/new_entry.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // _save() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'my_int_key';
  //   final value = 42;
  //   prefs.setInt(key, value);
  //   print('saved $value');
  // }

  void initState() {
    super.initState();
    //_saveData();
    // _readData();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3EB16F),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: TopContainer(),
            ),
            StreamBuilder<Object>(
                stream: _globalBloc.selectedPeriod$,
                builder: (context, snapshot) {
                  return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: snapshot.data == Period.Week ? 60 : 0,
                      child: snapshot.data == Period.Week
                          ? MiddleContainer()
                          : Container());
                }),
            Flexible(
              flex: 7,
              child: Provider<GlobalBloc>.value(
                child: BottomContainer(),
                value: _globalBloc,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF3EB16F),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewEntry()),
          );
        },
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      color: Color(0xFF3EB16F),
      width: double.infinity,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 30,
                top: 20,
              ),
              child: Text(
                "Medicine Reminder",
                style: TextStyle(
                  fontFamily: "Neu",
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
            Divider(
              color: Color(0xFFB0F3CB),
            ),
            StreamBuilder<Object>(
                stream: globalBloc.selectedPeriod$,
                builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            globalBloc.updateSelectedPeriod(Period.Week);
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              color: snapshot.data == Period.Week
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "This Week",
                                style: TextStyle(
                                  color: snapshot.data == Period.Week
                                      ? Color(0xFF3EB16F)
                                      : Color(0xFFB0F3CB),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            globalBloc.updateSelectedPeriod(Period.Month);
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              color: snapshot.data == Period.Month
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "This Month",
                                style: TextStyle(
                                  color: snapshot.data == Period.Month
                                      ? Color(0xFF3EB16F)
                                      : Color(0xFFB0F3CB),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            globalBloc.updateSelectedPeriod(Period.Year);
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              color: snapshot.data == Period.Year
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "This Year",
                                style: TextStyle(
                                  color: snapshot.data == Period.Year
                                      ? Color(0xFF3EB16F)
                                      : Color(0xFFB0F3CB),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class MiddleContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<Object>(
        stream: globalBloc.selectedDay$,
        builder: (context, snapshot) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    globalBloc.updateSelectedDay(Day.Saturday);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    child: Center(
                      child: Text(
                        "Sat",
                        style: TextStyle(
                          color: snapshot.data == (Day.Saturday)
                              ? Colors.black
                              : Color(0xFFC9C9C9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    globalBloc.updateSelectedDay(Day.Sunday);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    child: Center(
                      child: Text(
                        "Sun",
                        style: TextStyle(
                          color: snapshot.data == (Day.Sunday)
                              ? Colors.black
                              : Color(0xFFC9C9C9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    globalBloc.updateSelectedDay(Day.Monday);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    child: Center(
                      child: Text(
                        "Mon",
                        style: TextStyle(
                          color: snapshot.data == (Day.Monday)
                              ? Colors.black
                              : Color(0xFFC9C9C9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    globalBloc.updateSelectedDay(Day.Tuesday);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    child: Center(
                      child: Text(
                        "Tue",
                        style: TextStyle(
                          color: snapshot.data == (Day.Tuesday)
                              ? Colors.black
                              : Color(0xFFC9C9C9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    globalBloc.updateSelectedDay(Day.Wednesday);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    child: Center(
                      child: Text(
                        "Wed",
                        style: TextStyle(
                          color: snapshot.data == (Day.Wednesday)
                              ? Colors.black
                              : Color(0xFFC9C9C9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    globalBloc.updateSelectedDay(Day.Thursday);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    child: Center(
                      child: Text(
                        "Thu",
                        style: TextStyle(
                          color: snapshot.data == (Day.Thursday)
                              ? Colors.black
                              : Color(0xFFC9C9C9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    globalBloc.updateSelectedDay(Day.Friday);
                  },
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    child: Center(
                      child: Text(
                        "Fri",
                        style: TextStyle(
                          color: snapshot.data == (Day.Friday)
                              ? Colors.black
                              : Color(0xFFC9C9C9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<Medicine>(
        stream: _globalBloc.medicineList$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: Text("Please insert desired medicines"),
              ),
            );
          } else {
            return Container(
              color: Color(0xFFF6F8FC),
              child: GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return MedicineCard(
                    snapshot.data.medicineName,
                    snapshot.data.medicineType.toString().substring(13),
                    snapshot.data.interval,
                  );
                },
              ),
            );
          }
        });
  }
}

class MedicineCard extends StatelessWidget {
  final String name;
  final String type;
  final int interval;

  MedicineCard(this.name, this.type, this.interval);

  Icon makeIcon(double size) {
    if (type == "Bottle") {
      return Icon(
        IconData(0xe900, fontFamily: "Ic"),
        color: Color(0xFF3EB16F),
        size: size,
      );
    } else if (type == "Pill") {
      return Icon(
        IconData(0xe901, fontFamily: "Ic"),
        color: Color(0xFF3EB16F),
        size: size,
      );
    } else if (type == "Syringe") {
      return Icon(
        IconData(0xe902, fontFamily: "Ic"),
        color: Color(0xFF3EB16F),
        size: size,
      );
    } else if (type == "Tablet") {
      return Icon(
        IconData(0xe903, fontFamily: "Ic"),
        color: Color(0xFF3EB16F),
        size: size,
      );
    }
    return Icon(
      Icons.error,
      color: Color(0xFF3EB16F),
      size: 32,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(type);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              makeIcon(50.0),
              Text(
                name,
                style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF3EB16F),
                    fontWeight: FontWeight.w500),
              ),
              Text(
                interval == 1
                    ? "Every " + interval.toString() + " hour"
                    : "Every " + interval.toString() + " hour(s)";,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFC9C9C9),
                    fontWeight: FontWeight.w400),
              )
            ],
          ))),
    );
  }
}
