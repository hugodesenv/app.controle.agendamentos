import 'package:agendamentos/models/company.dart';
import 'package:agendamentos/models/generic_model.dart';
import '../enum/item_tipo_enum.dart';

class Item extends GenericModel {
  late Company _company;
  late String _description;
  late int _serviceMinutes;
  late bool _active;
  late ItemTipo _tipo;

  Item({
    String? itemId,
    Company? company,
    String? description,
    int? serviceMinutes,
    bool? active,
    ItemTipo? tipo,
  }) {
    id = itemId ?? '';
    _company = company ?? Company.empty();
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
      company: Company(id: data['fk_company'], socialName: ''),
      description: data['description'],
      serviceMinutes: data['service_minutes'],
      tipo: Item.toEnum(data['type']),
    );
  }

  static ItemTipo toEnum(String value) {
    return ItemTipo.values.firstWhere((element) {
      return element.typeCode == value;
    });
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

  Company get company => _company;

  set company(Company value) {
    _company = value;
  }
}
