import '../../../../model/checkbox/simpleContact.dart';

abstract class CustomerImportState {}

class CustomerImportStateInitial extends CustomerImportState {}

class CustomerImportStateContacts extends CustomerImportState {
  final List<CheckboxContact> _contacts;

  CustomerImportStateContacts(this._contacts);

  List<CheckboxContact> get contacts => _contacts;
}

class CustomerImportStateLoading extends CustomerImportState {}
