enum MyModalSearchEnum { tCustomer, tItem, tEmployee }

extension MyModalSearchDisplay on MyModalSearchEnum {
  displayTitle() {
    switch (this) {
      case MyModalSearchEnum.tCustomer:
        return 'Cliente';
      case MyModalSearchEnum.tItem:
        return 'Item';
      case MyModalSearchEnum.tEmployee:
        return 'Profissional';
    }
  }
}
