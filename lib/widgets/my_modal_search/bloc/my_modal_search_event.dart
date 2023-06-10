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
