abstract class CustomerImportEvent {}

class CustomerImportEventFetchAll extends CustomerImportEvent {}

class CustomerImportEventSubmitted extends CustomerImportEvent {}

/// control the state of checkbox in listview (selected or not)
class CustomerImportEventChanged extends CustomerImportEvent {
  final bool isSelected;
  final int index;

  CustomerImportEventChanged({required isSelected, required this.index}) : isSelected = isSelected ?? false;
}
