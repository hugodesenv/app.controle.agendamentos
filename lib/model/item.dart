import 'package:agendamentos/model/generic_model.dart';

import 'company.dart';

class Item extends GenericModel {
  String _description;
  String _barcode;

  Item({String? id, required String description, required String barcode})
      : _description = description,
        _barcode = barcode,
        super(id: id);

  Item copyWith({
    String? description,
    String? barcode,
    Company? company,
  }) {
    return Item(
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
    );
  }

  factory Item.fromJson(Map<dynamic, dynamic> json, String id) {
    return Item(
      id: id,
      description: json['description'],
      barcode: json['barcode'],
    );
  }

  factory Item.empty() {
    return Item(description: '', barcode: '');
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'description': description,
      'barcode': barcode,
    };

    return map;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get barcode => _barcode;

  set barcode(String value) {
    _barcode = value;
  }
}
