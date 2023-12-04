import 'empresa.dart';
import 'generic_model.dart';

class Usuario extends GenericModel {
  String _nome;
  String _usuario;
  String _email;
  Empresa _empresa;

  Usuario({
    String? nome,
    String? usuario,
    String? email,
    required Empresa empresa,
  })  : _nome = nome ?? '',
        _usuario = usuario ?? '',
        _email = email ?? '',
        _empresa = empresa;

  factory Usuario.empty() {
    return Usuario(
      empresa: Empresa.empty(),
    );
  }

  factory Usuario.fromMap(Map data) {
    Map? mapEmpresa = data['company'];

    var empresa = Empresa(
      id: mapEmpresa?['id'],
      razaoSocial: mapEmpresa?['social_name'],
      ativo: mapEmpresa?['active'],
    );

    return Usuario(
      nome: data['name'],
      usuario: data['username'],
      email: data['email'],
      empresa: empresa,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': nome,
      'username': usuario,
      'email': email,
      'company': empresa.toMap(),
    };
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get usuario => _usuario;

  set usuario(String value) {
    _usuario = value;
  }

  Empresa get empresa => _empresa;

  set empresa(Empresa value) {
    _empresa = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}
