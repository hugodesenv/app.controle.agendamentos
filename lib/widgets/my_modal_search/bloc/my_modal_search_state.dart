import '../model/my_modal_search_values.dart';

class MyModalSearchState {
  final List<MyModalSearchValues>? _values;

  MyModalSearchState({values}) : _values = values;

  List get values => _values ?? [];
}
