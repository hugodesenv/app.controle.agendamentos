import 'company.dart';

class Customer {
  String _id;
  String _name;
  String _cellphone;
  String _email;
  Company _company;

  Customer({String? id, String? name, String? cellphone, String? email, Company? company})
      : _id = id ?? '',
        _name = name ?? '',
        _cellphone = cellphone ?? '',
        _email = email ?? '',
        _company = Company.empty();

  factory Customer.fromJson(Map<dynamic, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      cellphone: json['cellphone'],
      email: json['email'],
      company: Company.fromJson(json['company']),
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
    return Customer();
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "cellphone": cellphone,
    };
  }

  String get id => _id;

  set id(String value) {
    _id = value;
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
