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
