class GenericModel {
  String? _id;

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

  GenericModel({id}) : _id = id;
}
