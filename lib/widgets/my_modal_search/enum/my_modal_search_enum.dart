enum MyModalSearchEnum { CUSTOMER, ITEM }

extension MyModalSearchDisplay on MyModalSearchEnum {
  displayTitle() {
    switch (this) {
      case MyModalSearchEnum.CUSTOMER:
        return 'Cliente';
      case MyModalSearchEnum.ITEM:
        return 'Item';
    }
  }
}
