import 'package:agendamentos/models/generic_model.dart';

import 'empresa.dart';

class Login extends GenericModel {
  String _name;
  Empresa _empresa;

  Login({
    required String id,
    required String name,
    required Empresa Empresa,
  })  : _name = name,
        _empresa = Empresa,
        super(id: id);

  factory Login.fromMap(Map<String, dynamic>? mapLogin) {
    return Login(
      Empresa: Empresa.fromJson(mapLogin?['Empresa']),
      id: mapLogin?['id'],
      name: mapLogin?['name'],
    );
  }

  factory Login.empty() {
    return Login(
      id: '',
      name: '',
      Empresa: Empresa.empty(),
    );
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Empresa get empresa => _empresa;

  set empresa(Empresa empresa) {
    _empresa = empresa;
  }
}
