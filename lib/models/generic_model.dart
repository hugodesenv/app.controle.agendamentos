enum ActionAPI { tUndefined, tInsert, tUpdate, tDeleted }

extension ActionAPIExtension on ActionAPI {
  String text() {
    switch (this) {
      case ActionAPI.tInsert:
        return 'insert';
      case ActionAPI.tUpdate:
        return 'update';
      case ActionAPI.tDeleted:
        return 'delete';
      case ActionAPI.tUndefined:
        return 'undefined';
    }
  }
}

class GenericModel {
  String? _id;
  ActionAPI action = ActionAPI.tUndefined;

  GenericModel({id}) : _id = id;

  String get id => _id ?? '';

  set id(String? value) {
    _id = value;
    action = _id == '' ? ActionAPI.tInsert : ActionAPI.tUpdate;
  }
}
