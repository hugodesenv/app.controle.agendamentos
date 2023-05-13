import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'customer_import_event.dart';
import 'customer_import_state.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomerImportBloc extends Bloc<CustomerImportEvent, CustomerImportState> {
  CustomerImportBloc(super.initialState) {
    on<CustomerImportEventFetchAll>(_fetchAll);
  }

  Future _fetchAll(event, emit) async {
    List<Contact> contacts = [];
    emit(CustomerImportStateLoading());

    var status = await Permission.contacts.request().isGranted;
    if (status) {
      contacts = await ContactsService.getContacts();
    }

    emit(CustomerImportStateContacts(contacts));
  }
}
