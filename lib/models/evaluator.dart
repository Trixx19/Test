import 'package:gonogo/models/child.dart';

class Evaluator {
  late String _id;
  late String _completeName;
  late String _photo;
  late String _email;
  late String _password;
  List<Child>? _children;

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

  String get photo {
    return _photo;
  }

  set sPhoto(String photo) {
    _photo = photo;
  }

  String get email {
    return _email;
  }

  set sEmail(String email) {
    _email = email;
  }

  String get password {
    return _password;
  }

  set sPassword(String password) {
    _password = password;
  }

  List<Child>? get children {
    return _children;
  }

  set sChildren(List<Child> children) {
    _children = children;
  }
}
