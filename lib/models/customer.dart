import 'package:agendamentos/models/generic_model.dart';

import 'company.dart';

class Customer extends GenericModel {
  String _name;
  String _cellphone;
  String _email;
  Company _company;

  Customer({
    required String? id,
    String? name,
    String? cellphone,
    String? email,
    required Company? company,
  })  : _name = name ?? '',
        _cellphone = cellphone ?? '',
        _email = email ?? '',
        _company = company ?? Company.empty(),
        super(id: id);

  factory Customer.fromJson(Map json) {
    Company company = Company.fromJson(json['company']);
    return Customer(
      id: json['id'],
      name: json['name'],
      cellphone: json['cellphone'],
      email: json['email'],
      company: company,
    );
  }

  Customer copyWith({String? id, String? name, String? cellphone, Company? company, String? email}) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      cellphone: cellphone ?? this.cellphone,
      email: email ?? this.email,
      company: company ?? this.company,
    );
  }

  factory Customer.empty() {
    return Customer(
      id: "",
      company: Company.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "cellphone": cellphone,
      "fk_company": company.id,
      "email": email,
    };
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get cellphone => _cellphone.toString().padLeft(10, '0');

  set cellphone(String value) {
    _cellphone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  Company get company => _company;

  set company(Company value) {
    _company = value;
  }
}
