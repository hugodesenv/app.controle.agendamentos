import 'package:agendamentos/models/generic_model.dart';

class Empresa extends GenericModel {
  String _razaoSocial;
  bool _ativo;

  Empresa({
    required String? id,
    required String? razaoSocial,
    bool? ativo,
  })  : _razaoSocial = razaoSocial ?? '',
        _ativo = ativo ?? false,
        super(id: id);

  factory Empresa.empty() {
    return Empresa(id: '', razaoSocial: '');
  }

  factory Empresa.fromJson(Map? json) {
    return Empresa(
      id: json?['id'],
      razaoSocial: json?['social_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'social_name': razaoSocial,
      'active': ativo,
    };
  }

  String get razaoSocial => _razaoSocial;

  bool get ativo => _ativo;

  set ativo(bool value) {
    _ativo = value;
  }

  set razaoSocial(String value) {
    _razaoSocial = value;
  }
}
