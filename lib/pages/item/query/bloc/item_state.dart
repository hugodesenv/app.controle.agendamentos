import '../../../../model/item.dart';

abstract class ItemState {}

class ItemStateInitial extends ItemState {}

class ItemStateHandleBarCode extends ItemState {
  String value;

  ItemStateHandleBarCode({required this.value});
}

class ItemStateSuccess extends ItemState {
  String message;

  ItemStateSuccess(this.message);
}

class ItemStateFailure extends ItemState {
  String error;

  ItemStateFailure(this.error);
}

class ItemStateRefreshList extends ItemState {
  List<Item> items;

  ItemStateRefreshList({required this.items});
}

class ItemStateLoading extends ItemState {}
