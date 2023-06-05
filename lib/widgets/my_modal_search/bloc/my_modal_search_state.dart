abstract class MyModalSearchState {}

class MyModalSearchStateInitial extends MyModalSearchState {}

/// the text field caption title
class MyModalSearchStateTextTitle extends MyModalSearchState {
  String textTitle;

  MyModalSearchStateTextTitle({required this.textTitle});
}

/// result a list of data, like: { "key": "123", "value": "Hugo S." }
class MyModalSearchStateLoaded extends MyModalSearchState {
  final List<Map<String, dynamic>> list;
  final String title;

  MyModalSearchStateLoaded({
    required this.title,
    required this.list,
  });
}

/// when the app is loading the list view
class MyModalSearchStateLoading extends MyModalSearchState {}

class MyModalSearchStateClickedData extends MyModalSearchState {
  final Map<String, dynamic> data;

  MyModalSearchStateClickedData({required this.data});
}
