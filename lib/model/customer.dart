class Customer {
  String _name;
  String _cellphone;

  Customer({String? name, String? cellphone})
      : _name = name!,
        _cellphone = cellphone!;

  factory Customer.empty() {
    return Customer(name: '', cellphone: '');
  }

  Customer copyWith({String? name, String? cellphone}) {
    return Customer(
      name: name ?? this.name,
      cellphone: cellphone ?? this.cellphone,
    );
  }

  String get cellphone => _cellphone ?? '';

  set cellphone(String value) {
    _cellphone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
