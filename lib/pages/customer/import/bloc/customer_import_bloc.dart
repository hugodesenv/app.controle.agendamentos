import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/checkbox_contact.dart';
import 'customer_import_event.dart';
import 'customer_import_state.dart';

class CustomerImportBloc extends Bloc<CustomerImportEvent, CustomerImportState> {
  final List<CheckboxContact> _contactList = [];

  CustomerImportBloc(super.initialState) {
    on<CustomerImportEventFetchAll>(_fetchAll);
    on<CustomerImportEventSubmitted>(_submitted);
    on<CustomerImportEventChanged>(_handleChecked);
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
      CheckboxContact simpleContact = CheckboxContact(
        contact: contact,
        isChecked: false,
      );

      _contactList.add(simpleContact);
    }

    emit(CustomerImportStateContacts(_contactList));
  }

  ///this event is invoked when the user select a list of contacts to import in database like customer
  void _submitted(CustomerImportEventSubmitted event, emit) {
    emit(CustomerImportStateLoading());
    try {
      List<CheckboxContact> checkedList = _contactList.where((e) => e.isChecked == true).toList();
      var repository = CustomerRepository.instance;

      for (var i in checkedList) {
        var customer = Customer(cellphone: i.contact.phones?[0].value, name: i.contact.displayName!);
        repository.save(customer);
      }

      emit(CustomerImportStateSuccess('Operação finalizada! ${checkedList.length} registros!'));
    } catch (e) {
      emit(CustomerImportStateFailure('Falha: ${e.toString()}'));
    }
  }

  ///this event is invoked when the user check or uncheck the value in list
  void _handleChecked(CustomerImportEventChanged event, emit) {
    _contactList[event.index].isChecked = event.isSelected;
    emit(CustomerImportStateContacts(_contactList));
  }
}
