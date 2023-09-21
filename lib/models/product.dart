import 'generic_model.dart';

class Product extends GenericModel {
  String _description;
  String _barcode;

  Product({required String id, required String description, required String barcode})
      : _description = description,
        _barcode = barcode,
        super(id: id);

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get barcode => _barcode;

  set barcode(String value) {
    _barcode = value;
  }
}
