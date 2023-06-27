import 'package:agendamentos/model/generic_model.dart';

import 'company.dart';

enum ItemType { product, service, undefined }

class Item extends GenericModel {
  ItemType? _type;
  String? _description;
  String? _barcode;

  Item({String? id, required String? description, required String? barcode, required ItemType? type})
      : _description = description ?? '',
        _barcode = barcode ?? '',
        _type = type ?? ItemType.undefined,
        super(id: id);

  Item copyWith({String? description, String? barcode, Company? company, ItemType? type}) {
    return Item(
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
      type: type ?? this.type,
    );
  }

  factory Item.fromJson(Map<dynamic, dynamic> json, String id) {
    print(json);
    return Item(
      id: id ?? '',
      description: json['description'] ?? '',
      barcode: json['barcode'] ?? '',
      type: getTypeFromString(json['type']),
    );
  }

  factory Item.empty() {
    return Item(
      description: '',
      barcode: '',
      type: ItemType.undefined,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'description': description,
      'barcode': barcode,
      'type': type.name,
    };

    return map;
  }

  static ItemType getTypeFromString(String? pType) {
    return ItemType.values.firstWhere(
      (e) => e.name == (pType ?? ''),
      orElse: () => ItemType.undefined,
    );
  }

  String get description => _description ?? '';

  set description(String value) {
    _description = value;
  }

  String get barcode => _barcode ?? '';

  set barcode(String value) {
    _barcode = value;
  }

  ItemType get type => _type ?? ItemType.undefined;

  set type(ItemType value) {
    _type = value;
  }
}
