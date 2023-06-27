import 'package:agendamentos/model/item.dart';

abstract class ItemEvent {}

class ItemEventShowBarCode extends ItemEvent {}

class ItemEventSave extends ItemEvent {}

class ItemEventSetValues extends ItemEvent {
  String? description;
  String? barcode;
  ItemType? type;

  ItemEventSetValues({this.type, this.description, this.barcode});
}

class ItemEventFetchAll extends ItemEvent {}
