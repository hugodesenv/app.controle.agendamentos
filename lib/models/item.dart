import 'package:agendamentos/models/empresa.dart';
import 'package:agendamentos/models/generic_model.dart';
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
    _active = active ?? false;
    _tipo = tipo ?? ItemTipo.INDEFINIDO;
  }

  factory Item.empty() {
    return Item();
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

  static String obterDescricaoEnumTipo(ItemTipo pTipo) {
    switch (pTipo) {
      case ItemTipo.INDEFINIDO:
        return 'Indefinido';
      case ItemTipo.PRODUTO:
        return 'Produto';
      case ItemTipo.SERVICO:
        return 'Serviço';
    }
  }

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
