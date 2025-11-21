class Child {
  late String _id;
  late String _completeName;
  late String _date;
  late String _color;
  late String _sex;
  late String _income;
  late String _timeGadgets;
  late String _timePlay;
  late String _timeOut;
  late int _boolTests;
  Child(
      this._id,
      this._completeName,
      this._date,
      this._color,
      this._sex,
      this._income,
      this._timeGadgets,
      this._timePlay,
      this._timeOut,
      this._boolTests);

  String get id {
    return _id;
  }

  set sId(String id) {
    _id = id;
  }

  String get completeName {
    return _completeName;
  }

  set sCompleteName(String completeName) {
    _completeName = completeName;
  }

  String get date {
    return _date;
  }

  set sDate(String date) {
    _date = date;
  }

  String get color {
    return _color;
  }

  set sColor(String color) {
    _color = color;
  }

  String get sex {
    return _sex;
  }

  set sSex(String sex) {
    _sex = sex;
  }

  String get income {
    return _income;
  }

  set sIncome(String income) {
    _income = income;
  }

  String get timeGadgets {
    return _timeGadgets;
  }

  set sTimeGadgets(String timeGadgets) {
    _timeGadgets = timeGadgets;
  }

  String get timePlay {
    return _timePlay;
  }

  set sTimePlay(String timePlay) {
    _timePlay = timePlay;
  }

  String get timeOut {
    return _timeOut;
  }

  set sTimeOut(String timeOut) {
    _timeOut = timeOut;
  }

  int get boolTests {
    return _boolTests;
  }

  set sBoolTests(int boolTests) {
    _boolTests = boolTests;
  }
}
