import 'package:agendamentos/model/utils/simpleContact.dart';

abstract class CustomerImportState {}

class CustomerImportStateInitial extends CustomerImportState {}

class CustomerImportStateContacts extends CustomerImportState {
  final List<SimpleContact> _contacts;

  CustomerImportStateContacts(this._contacts);

  List<SimpleContact> get contacts => _contacts;
}

class CustomerImportStateLoading extends CustomerImportState {}
