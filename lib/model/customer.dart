import 'package:agendamentos/model/generic_model.dart';

class Customer extends GenericModel {
  String _name;
  String _cellphone;

  Customer({String? id, String? name, String? cellphone})
      : _name = name ?? '',
        _cellphone = cellphone ?? '',
        super(id: id);

  factory Customer.empty() {
    return Customer(id: null, name: '', cellphone: '');
  }

  factory Customer.fromJson(Map<dynamic, dynamic> json, String id) {
    return Customer(
      id: id,
      name: json['name'],
      cellphone: json['cellphone'],
    );
  }

  Customer copyWith({String? id, String? name, String? cellphone}) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      cellphone: cellphone ?? this.cellphone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "cellphone": cellphone,
    };
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get cellphone => _cellphone;

  set cellphone(String value) {
    _cellphone = value;
  }
}
