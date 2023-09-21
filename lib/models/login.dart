import 'package:agendamentos/models/generic_model.dart';

import 'company.dart';

class Login extends GenericModel {
  String _name;
  Company _company;

  Login({required String id, required String name, required Company company})
      : _name = name,
        _company = company,
        super(id: id);

  factory Login.fromMap(Map<String, dynamic>? mapLogin) {
    return Login(
      company: Company.fromJson(mapLogin?['company']),
      id: mapLogin?['id'],
      name: mapLogin?['name'],
    );
  }

  factory Login.empty() {
    return Login(
      name: '',
      id: '',
      company: Company.empty(),
    );
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Company get company => _company;

  set company(Company value) {
    _company = value;
  }
}
