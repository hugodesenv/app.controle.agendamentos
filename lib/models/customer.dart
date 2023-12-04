import 'package:agendamentos/models/generic_model.dart';
import 'empresa.dart';

class Customer extends GenericModel {
  String _name;
  String _cellphone;
  String _email;
  Empresa _empresa;

  Customer({
    required String? id,
    String? name,
    String? cellphone,
    String? email,
    Empresa? empresa,
  })  : _name = name ?? '',
        _cellphone = cellphone ?? '',
        _email = email ?? '',
        _empresa = empresa ?? Empresa.empty(),
        super(id: id);

  factory Customer.fromJson(Map json) {
    Empresa empresa = Empresa.fromJson(json['company']);
    return Customer(
      id: json['id'],
      name: json['name'],
      cellphone: json['cellphone'],
      email: json['email'],
      empresa: empresa,
    );
  }

  Customer copyWith({
    String? id,
    String? name,
    String? cellphone,
    Empresa? empresa,
    String? email,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      cellphone: cellphone ?? this.cellphone,
      email: email ?? this.email,
      empresa: empresa ?? this._empresa,
    );
  }

  factory Customer.empty() {
    return Customer(
      id: "",
      empresa: Empresa.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "cellphone": cellphone,
      "fk_company": empresa.id,
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

  Empresa get empresa => _empresa;

  set empresa(Empresa value) {
    _empresa = value;
  }
}
