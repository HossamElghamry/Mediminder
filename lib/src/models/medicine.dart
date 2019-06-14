class Medicine {
  final String _medicineName;
  final int _pillDosage;
  final List<int> _doseTimings;

  Medicine(
    this._medicineName,
    this._pillDosage,
    this._doseTimings,
  );

  String get medicineName => _medicineName;
  int get pillDosage => _pillDosage;
  List<int> get doseTimings => _doseTimings;
}
