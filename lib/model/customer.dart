class Customer {
  String _name = '';
  String? _cellphone;

  Customer({required String name, String? cellphone})
      : _name = name,
        _cellphone = cellphone;

  String get cellphone => _cellphone ?? '';

  set cellphone(String value) {
    _cellphone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
