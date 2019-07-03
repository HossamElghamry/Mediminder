class Medicine {
  final List<dynamic> notificationIDs;
  final String medicineName;
  final int dosage;
  final String medicineType;
  final int interval;
  final String startTime;

  Medicine({
    this.notificationIDs,
    this.medicineName,
    this.dosage,
    this.medicineType,
    this.startTime,
    this.interval,
  });

  String get getName => medicineName;
  int get getDosage => dosage;
  String get getType => medicineType;
  int get getInterval => interval;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;

  Map<String, dynamic> toJson() {
    return {
      "ids": this.notificationIDs,
      "name": this.medicineName,
      "dosage": this.dosage,
      "type": this.medicineType,
      "interval": this.interval,
      "start": this.startTime,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(
      notificationIDs: parsedJson['ids'],
      medicineName: parsedJson['name'],
      dosage: parsedJson['dosage'],
      medicineType: parsedJson['type'],
      interval: parsedJson['interval'],
      startTime: parsedJson['start'],
    );
  }
}
