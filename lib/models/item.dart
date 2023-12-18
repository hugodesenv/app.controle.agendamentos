/// mudar aqui de ingles para portugues.
import 'package:agendamentos/models/empresa.dart';
import 'package:agendamentos/models/generic_model.dart';
import 'package:agendamentos/utils/preferences_util.dart';
import '../enum/item_tipo_enum.dart';

class Item extends GenericModel {
  late Empresa _empresa;
  late String _description;
  late int _serviceMinutes;
  late bool _active;
  late ItemTipo _tipo;

  Item({
    String? itemId,
    Empresa? company,
    String? description,
    int? serviceMinutes,
    bool? active,
    ItemTipo? tipo,
  }) {
    id = itemId ?? '';
    _empresa = company ?? Empresa.empty();
    _description = description ?? '';
    _serviceMinutes = serviceMinutes ?? 0;
    _active = active ?? true;
    _tipo = tipo ?? ItemTipo.INDEFINIDO;
  }

  Item copyWith({
    String? descricao,
    ItemTipo? tipo,
    Empresa? empresa,
    bool? ativo,
  }) {
    return Item(
      description: descricao ?? description,
      tipo: tipo ?? this.tipo,
      company: empresa ?? this.empresa,
      active: ativo ?? active,
    );
  }

  factory Item.empty() {
    return Item();
  }

  Map toJson() {
    return {
      'action': action.text(),
      'fk_company': empresa.id,
      'description': description,
      'service_minutes': serviceMinutes,
      'active': active,
      'type': tipo.options()[ItemTipoOpcoes.CODIGO],
    };
  }

  factory Item.fromJson(Map data) {
    return Item(
      itemId: data['id'],
      active: data['active'],
      company: Empresa(id: data['fk_company'], razaoSocial: ''),
      description: data['description'],
      serviceMinutes: data['service_minutes'],
      tipo: Item.toEnumTipo(data['type']),
    );
  }

  static ItemTipo toEnumTipo(String value) {
    return ItemTipo.values.firstWhere((element) {
      return element.typeCode == value;
    });
  }

  String obterDescricaoAtivo() => active ? 'Ativo' : 'Inativo';

  ItemTipo get tipo => _tipo;

  set tipo(ItemTipo tipo) {
    _tipo = tipo;
  }

  bool get active => _active;

  set active(bool value) {
    _active = value;
  }

  int get serviceMinutes => _serviceMinutes;

  set serviceMinutes(int value) {
    _serviceMinutes = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  Empresa get empresa => _empresa;

  set empresa(Empresa value) {
    _empresa = value;
  }
}
