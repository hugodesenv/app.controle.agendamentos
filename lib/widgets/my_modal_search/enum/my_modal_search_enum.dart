enum MyModalSearchEnum { CUSTOMER, ITEM, EMPLOYEE }

extension MyModalSearchDisplay on MyModalSearchEnum {
  displayTitle() {
    switch (this) {
      case MyModalSearchEnum.CUSTOMER:
        return 'Cliente';
      case MyModalSearchEnum.ITEM:
        return 'Item';
      case MyModalSearchEnum.EMPLOYEE:
        return 'Profissional';
    }
  }
}
