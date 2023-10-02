import 'package:agendamentos/models/generic_model.dart';

import '../models/company.dart';

class Employee extends GenericModel {
  String _name;
  bool _active;
  Company _company;

  Employee({
    required String? id,
    String? name,
    bool? active,
    Company? company,
  })  : _name = name ?? '',
        _active = active ?? false,
        _company = company ?? Company.empty(),
        super(id: id);

  factory Employee.empty() {
    return Employee(id: "", company: Company.empty());
  }

  factory Employee.fromJson(Map? data) {
    Company company = Company.fromJson(data?['company']);
    return Employee(
      id: data?['id'],
      company: company,
      active: data?['active'],
      name: data?['name'],
    );
  }

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
}
