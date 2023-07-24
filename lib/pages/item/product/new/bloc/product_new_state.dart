class ProductNewState {
  final String? _barcode;

  ProductNewState({String? barcode}) : _barcode = barcode ?? '';

  ProductNewState copyWith({String? barcode}) {
    return ProductNewState(
      barcode: barcode ?? _barcode,
    );
  }

  String get barcode => _barcode ?? '';
}
