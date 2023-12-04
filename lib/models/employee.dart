import 'package:agendamentos/models/empresa.dart';
import 'package:agendamentos/models/generic_model.dart';

class Employee extends GenericModel {
  String _nome;
  bool _ativo;
  Empresa _empresa;

  Employee({
    required String? id,
    String? nome,
    bool? ativo,
    Empresa? empresa,
  })  : _nome = nome ?? '',
        _ativo = ativo ?? false,
        _empresa = empresa ?? Empresa.empty(),
        super(id: id);

  factory Employee.empty() {
    return Employee(
      id: '',
      empresa: Empresa.empty(),
    );
  }

  factory Employee.fromJson(Map? data) {
    var empresa = Empresa.fromJson(data?['company']);
    return Employee(
      id: data?['id'],
      empresa: empresa,
      ativo: data?['active'],
      nome: data?['name'],
    );
  }

  Empresa get empresa => _empresa;

  set empresa(Empresa value) {
    _empresa = value;
  }

  bool get ativo => _ativo;

  set ativo(bool value) {
    _ativo = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}
