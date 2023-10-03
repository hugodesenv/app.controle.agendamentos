import 'package:agendamentos/models/company.dart';
import 'package:agendamentos/models/generic_model.dart';

class Account extends GenericModel {
  String _name;
  String _username;
  String _email;
  Company _company;

  Account({required String? name, required String? username, required String? email, required Company? company})
      : _name = name ?? '',
        _username = username ?? '',
        _email = email ?? '',
        _company = company ?? Company.empty();

  factory Account.empty() {
    return Account(
      name: "",
      username: "",
      email: "",
      company: Company.empty(),
    );
  }

  factory Account.fromMap(Map data) {
    Map? mapCompany = data['company'];
    Company company = Company(
      id: mapCompany?['id'],
      socialName: mapCompany?['social_name'],
      active: mapCompany?['active'],
    );

    return Account(
      name: data['name'],
      username: data['username'],
      email: data['email'],
      company: company,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'company': company.toMap(),
    };
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  Company get company => _company;

  set company(Company value) {
    _company = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}
