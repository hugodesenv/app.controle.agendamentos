abstract class MyModalSearchEvent {}

/// get the current data by id
class MyModalSearchEventFetchByID extends MyModalSearchEvent {
  final String columnShow;
  final String collection;
  final String id;

  MyModalSearchEventFetchByID(this.columnShow, this.collection, this.id);
}

/// fetch all data in database (when the modal is opened)
class MyModalSearchEventFetchAll extends MyModalSearchEvent {
  final String columnShow;
  final String collection;

  MyModalSearchEventFetchAll({
    required this.columnShow,
    required this.collection,
  });
}

/// used to filter the register in list
class MyModalSearchEventFilterData extends MyModalSearchEvent {
  final String _value;
  final String _columnToFilter;

  MyModalSearchEventFilterData({
    required String value,
    required String columnToFilter,
  })  : _value = value,
        _columnToFilter = columnToFilter;

  String get value => _value.toLowerCase();

  String get columnToFilter => _columnToFilter.trim();
}
