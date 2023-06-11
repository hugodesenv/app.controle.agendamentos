abstract class ItemEvent {}

class ItemEventShowBarCode extends ItemEvent {}

class ItemEventSave extends ItemEvent {}

/// Pass the values from edit to class
class ItemEventSetValues extends ItemEvent {
  String? description;
  String? barcode;

  ItemEventSetValues({this.description, this.barcode});
}
