class Customer {
  String _id;
  String _name;
  String _cellphone;

  Customer({String? id, String? name, String? cellphone})
      : _id = id ?? '',
        _name = name ?? '',
        _cellphone = cellphone ?? '';

  factory Customer.empty() {
    return Customer(name: '', cellphone: '');
  }

  factory Customer.fromJson(Map<dynamic, dynamic> json, String id) {
    return Customer(
      id: id,
      name: json['name'],
      cellphone: json['cellphone'],
    );
  }

  Customer copyWith({String? id, String? name, String? cellphone}) {
    return Customer(
      id: id ?? this.id,
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

  String get id => _id ?? '';

  String get cellphone => _cellphone ?? '';

  set cellphone(String value) {
    _cellphone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
