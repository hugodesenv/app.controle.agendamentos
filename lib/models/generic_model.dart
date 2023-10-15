enum ActionAPI { tInsert, tUpdate, tDeleted }

extension ActionAPIExtension on ActionAPI {
  String text() {
    switch (this) {
      case ActionAPI.tInsert:
        return 'insert';
      case ActionAPI.tUpdate:
        return 'update';
      case ActionAPI.tDeleted:
        return 'delete';
    }
  }
}

class GenericModel {
  String _id;
  late ActionAPI action;

  GenericModel({String? id}) : _id = id ?? '' {
    action = ActionAPI.tInsert;
  }

  String get id => _id;

  set id(String value) {
    _id = value;

    if (id.isNotEmpty) {
      action = ActionAPI.tInsert;
    }
  }
}
