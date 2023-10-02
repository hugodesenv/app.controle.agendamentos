class GenericModel {
  String? _id;

  GenericModel({id}) : _id = id;

  String get id => _id ?? '';

  set id(String? value) {
    _id = value;
  }

  String get action => id.isEmpty ? 'insert' : 'update';
}
