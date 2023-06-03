abstract class ItemState {}

class ItemStateInitial extends ItemState {}

class ItemStateHandleBarCode extends ItemStateInitial {
  String value;

  ItemStateHandleBarCode({required this.value});
}
