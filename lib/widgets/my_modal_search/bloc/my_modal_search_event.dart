import 'package:agendamentos/widgets/my_modal_search/enum/enumTypeModel.dart';

abstract class MyModalSearchEvent {}

class MyModalSearchEventInitial extends MyModalSearchEvent {
  final TypeModal typeModal;

  MyModalSearchEventInitial({required this.typeModal});
}

/// fetch data in firebase
class MyModalSearchEventFetchData extends MyModalSearchEvent {
  final TypeModal typeModal;

  MyModalSearchEventFetchData({required this.typeModal});
}

/// on click item, resulting the current clicked data
class MyModalSearchEventTapItem extends MyModalSearchEvent {
  final Map<String, dynamic> data;

  MyModalSearchEventTapItem({required this.data});
}
