import 'package:agendamentos/model/generic_model.dart';

import 'company.dart';

class Product extends GenericModel {
  String _description;
  String _barcode;

  Product({
    required String description,
    required String barcode,
  })  : _description = description,
        _barcode = barcode;

  Product copyWith({
    String? description,
    String? barcode,
    Company? company,
  }) {
    return Product(
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
    );
  }

  factory Product.empty() {
    return Product(description: '', barcode: '');
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
