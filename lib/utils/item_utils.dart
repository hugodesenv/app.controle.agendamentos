enum ItemType { tUndefined, tProduct, tService }

extension ItemTypeExtension on ItemType {
  String text() {
    switch (this) {
      case ItemType.tProduct:
        return 'product';
      case ItemType.tService:
        return 'service';
      default:
        return 'undefined';
    }
  }
}
