enum ItemType {
  tUndefined,
  tProduct,
  tService,
}

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

class ItemUtils {
  static ItemType toEnum(String value) {
    for (var data in ItemType.values) {
      if (data.text() == value) return data;
    }
    return ItemType.tUndefined;
  }
}
