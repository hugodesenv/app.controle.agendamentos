import 'package:contacts_service/contacts_service.dart';

abstract class CustomerImportState {}

class CustomerImportStateInitial extends CustomerImportState {}

class CustomerImportStateContacts extends CustomerImportState {
  final List<Contact> _contacts;

  CustomerImportStateContacts(this._contacts);

  List<Contact> get contacts => _contacts;
}

class CustomerImportStateLoading extends CustomerImportState {}
