class MyModalSearchState {
  final List<MyModalSearchValues>? _values;

  MyModalSearchState({values}) : _values = values;

  List get values => _values ?? [];
}

class MyModalSearchValues {
  String id;
  String title;
  String subtitle;

  MyModalSearchValues(this.id, this.title, this.subtitle);
}
