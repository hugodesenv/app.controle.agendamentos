import '../model/checkbox_contact.dart';

abstract class CustomerImportState {}

class CustomerImportStateInitial extends CustomerImportState {}

/// returns a list of checkbox contacts
class CustomerImportStateContacts extends CustomerImportState {
  final List<CheckboxContact> _contacts;

  CustomerImportStateContacts(this._contacts);

  List<CheckboxContact> get contacts => _contacts;
}

/// when the controller is busy
class CustomerImportStateLoading extends CustomerImportState {}

/// when the import successfully
class CustomerImportStateSuccess extends CustomerImportState {
  final String message;

  CustomerImportStateSuccess(this.message);
}

/// when occurs some error
class CustomerImportStateFailure extends CustomerImportState {
  final String error;

  CustomerImportStateFailure(this.error);
}
