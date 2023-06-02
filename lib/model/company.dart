import 'package:agendamentos/model/generic_model.dart';

class Company extends GenericModel {
  String _name;

  Company({required String id, required String name})
      : _name = name,
        super(id: id);

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'],
      name: map['name'],
    );
  }

  factory Company.empty() {
    return Company(id: '', name: '');
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
