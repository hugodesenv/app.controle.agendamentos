import 'package:agendamentos/widgets/my_modal_search/enum/my_modal_search_enum.dart';

abstract class MyModalSearchEvent {}

class MyModalSearchEventFindAll extends MyModalSearchEvent {
  MyModalSearchEnum typeSelection;

  MyModalSearchEventFindAll(this.typeSelection);
}

class MyModalSearchEventChangeFilter extends MyModalSearchEvent {
  late String _value;

  MyModalSearchEventChangeFilter({required String value}) {
    _value = value;
  }

  String get value => _value;

  set value(String value) {
    _value = value.toLowerCase();
  }
}
