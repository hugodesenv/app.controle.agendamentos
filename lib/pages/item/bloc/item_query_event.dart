abstract class ItemQueryEvent {}

class ItemQueryEventHandleTitle extends ItemQueryEvent {
  final int index;

  ItemQueryEventHandleTitle(this.index);
}
