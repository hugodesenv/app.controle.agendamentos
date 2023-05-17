class Customer {
  String _name;
  String _cellphone;

  Customer({String? name, String? cellphone})
      : _name = name ?? '',
        _cellphone = cellphone ?? '';

  factory Customer.empty() {
    return Customer(name: '', cellphone: '');
  }

  factory Customer.fromJson(Map<dynamic, dynamic> json) {
    return Customer(
      name: json['name'],
      cellphone: json['cellphone'],
    );
  }

  Customer copyWith({String? name, String? cellphone}) {
    return Customer(
      name: name ?? this.name,
      cellphone: cellphone ?? this.cellphone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "cellphone": cellphone,
    };
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
