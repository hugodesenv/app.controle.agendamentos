import 'package:agendamentos/widgets/my_modal_search/enum/my_modal_search_enum.dart';

abstract class MyModalSearchEvent {}

class MyModalSearchEventFindAll extends MyModalSearchEvent {
  MyModalSearchEnum typeSelection;

  MyModalSearchEventFindAll(this.typeSelection);
}
