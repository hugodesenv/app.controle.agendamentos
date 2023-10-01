import 'package:agendamentos/models/company.dart';
import 'package:agendamentos/models/generic_model.dart';
import 'package:agendamentos/utils/item_utils.dart';

class Item extends GenericModel {
  late Company _company;
  late String _description;
  late int _serviceMinutes;
  late bool _active;
  late ItemType _type;

  Item({
    required Company company,
    required String description,
    required int serviceMinutes,
    required bool active,
    required ItemType type,
  }) {
    _company = company;
    _description = description;
    _serviceMinutes = serviceMinutes;
    _active = active;
    _type = type;
  }

  static Item empty() {
    return Item(
      company: Company.empty(),
      description: '',
      serviceMinutes: 0,
      active: false,
      type: ItemType.tUndefined,
    );
  }

  ItemType get type => _type;

  set type(ItemType value) {
    _type = value;
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
