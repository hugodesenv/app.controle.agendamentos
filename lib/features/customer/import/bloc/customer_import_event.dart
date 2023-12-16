abstract class CustomerImportEvent {}

/// fetch all local contacts in him cellphone
class CustomerImportEventFetchAll extends CustomerImportEvent {}

/// when the user decides he wants import the data
class CustomerImportEventSubmitted extends CustomerImportEvent {}

/// control the state of checkbox in listview (selected or not)
class CustomerImportEventChanged extends CustomerImportEvent {
  final bool isSelected;
  final int index;

  CustomerImportEventChanged({required isSelected, required this.index}) : isSelected = isSelected ?? false;
}
