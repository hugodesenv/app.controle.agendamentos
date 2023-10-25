import 'package:agendamentos/models/company.dart';
import 'package:agendamentos/models/generic_model.dart';

class Item extends GenericModel {
  late Company _company;
  late String _description;
  late int _serviceMinutes;
  late bool _active;
  late ItemType _type;

  Item({
    String? itemId,
    Company? company,
    String? description,
    int? serviceMinutes,
    bool? active,
    ItemType? type,
  }) {
    id = itemId ?? '';
    _company = company ?? Company.empty();
    _description = description ?? '';
    _serviceMinutes = serviceMinutes ?? 0;
    _active = active ?? false;
    _type = type ?? ItemType.tUndefined;
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
      type: ItemUtils.toEnum(data['type']),
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

enum ItemType {
  tUndefined,
  tProduct,
  tService,
}

enum ItemTypeOptions {
  tCode,
  tDescription,
}

extension ItemTypeExtension on ItemType {
  String get typeCode => options()[ItemTypeOptions.tCode];
  String get typeDescription => options()[ItemTypeOptions.tDescription];

  Map<ItemTypeOptions, dynamic> options() {
    switch (this) {
      case ItemType.tProduct:
        return {
          ItemTypeOptions.tCode: 'product',
          ItemTypeOptions.tDescription: 'Produto',
        };
      case ItemType.tService:
        return {
          ItemTypeOptions.tCode: 'service',
          ItemTypeOptions.tDescription: 'Serviço',
        };
      default:
        return {
          ItemTypeOptions.tCode: 'undefined',
          ItemTypeOptions.tDescription: 'Indefinido',
        };
    }
  }
}

class ItemUtils {
  static ItemType toEnum(String value) {
    return ItemType.values.firstWhere((element) {
      return element.typeCode == value;
    });
  }
}
