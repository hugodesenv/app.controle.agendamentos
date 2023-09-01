import '../model/company.dart';

class Employee {
  String _id;
  String _name;
  bool _active;
  Company _company;

  Employee({required String id, required String name, required bool active, required Company company})
      : _id = id,
        _name = name,
        _active = active,
        _company = company;

  Company get company => _company;

  set company(Company value) {
    _company = value;
  }

  bool get active => _active;

  set active(bool value) {
    _active = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
