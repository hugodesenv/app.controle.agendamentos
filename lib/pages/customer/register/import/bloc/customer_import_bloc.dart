import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'customer_import_event.dart';
import 'customer_import_state.dart';

class CustomerImportBloc extends Bloc<CustomerImportEvent, CustomerImportState> {
  CustomerImportBloc(super.initialState) {
    on<CustomerImportEventFetchAll>(_fetchAll);
  }

  Future _fetchAll(event, emit) async {
    Incluir logica para permitir abrir os contatos aqui
    List<Contact> contacts = await ContactsService.getContacts();
    emit(CustomerImportStateContacts(contacts));
  }
}
