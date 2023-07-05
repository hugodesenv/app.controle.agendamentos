abstract class ItemQueryState {}

class ItemQueryStateInitial extends ItemQueryState {}

class ItemQueryStateChangeTitle extends ItemQueryState {
  final String title;

  ItemQueryStateChangeTitle(this.title);
}
