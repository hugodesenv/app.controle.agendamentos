import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../model/utils/simpleContact.dart';
import 'customer_import_event.dart';
import 'customer_import_state.dart';

class CustomerImportBloc extends Bloc<CustomerImportEvent, CustomerImportState> {
  final List<SimpleContact> _contactList = [];

  CustomerImportBloc(super.initialState) {
    on<CustomerImportEventFetchAll>(_fetchAll);
    on<CustomerImportEventSubmitted>(_submitted);
  }

  ///this event is invoked to list all cellphone user contacts
  Future _fetchAll(event, emit) async {
    List<Contact> contacts = [];
    _contactList.clear();

    emit(CustomerImportStateLoading());

    var status = await Permission.contacts.request().isGranted;
    if (status) {
      contacts = await ContactsService.getContacts();
    }

    for (var contact in contacts) {
      SimpleContact simpleContact = SimpleContact(contact: contact, isChecked: false);
      _contactList.add(simpleContact);
    }

    emit(CustomerImportStateContacts(_contactList));
  }

  ///this event is invoked when the user select a list of contacts to import in database like customer
  void _submitted(CustomerImportEventSubmitted event, emit) {}
}
