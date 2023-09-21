enum MyModalSearchEnum { CUSTOMER }

extension MyModalSearchDisplay on MyModalSearchEnum {
  displayTitle() {
    switch (this) {
      case MyModalSearchEnum.CUSTOMER:
        return 'Cliente';
    }
  }
}
