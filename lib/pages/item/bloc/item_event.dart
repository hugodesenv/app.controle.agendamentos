abstract class ItemEvent {}

class ItemEventShowBarCode extends ItemEvent {}

class ItemEventSave extends ItemEvent {}

class ItemEventSetValues extends ItemEvent {
  String? description;
  String? barcode;

  ItemEventSetValues({this.description, this.barcode});
}

class ItemEventFetchAll extends ItemEvent {}
