import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerQueryBloc extends Bloc<CustomerQueryEvent, CustomerQueryState> {
  List<Customer> _customers = [];

  CustomerQueryBloc(super.initialState) {
    on<CustomerQueryEventFetchAll>(fetchAll);
    on<CustomerQueryEventRemoveFromList>(removeFromList);
    on<CustomerQueryEventOpen>((event, emit) => emit(CustomerQueryStateOpen(event.typeOpen)));
    on<CustomerQueryEventAddToList>(addToList);
    on<CustomerQueryEventOnChangedFilter>(changedFilter);
    on<CustomerQueryEventTeste>((event, emit) => emit(CustomerQueryStateTeste()));
  }

  void fetchAll(event, emit) async {
    emit(CustomerQueryStateLoading(true));

    var repository = CustomerRepository.instance;

    _customers.clear();
    _customers.addAll(await repository.fetchData());

    emit(CustomerQueryStateRefreshList(_customers));
  }

  void removeFromList(event, emit) {
    emit(CustomerQueryStateLoading(true));
    _customers.remove(event.customer);
    emit(CustomerQueryStateRefreshList(_customers));
  }

  void addToList(CustomerQueryEventAddToList event, emit) {
    emit(CustomerQueryStateLoading(true));
    _customers.add(event.customer);
    emit(CustomerQueryStateRefreshList(_customers));
  }

  void changedFilter(CustomerQueryEventOnChangedFilter event, emit) {
    String textFilter = event.value;
    List<Customer> tempCustomers = [];
    tempCustomers.addAll(_customers);

    if (textFilter.isNotEmpty) {
      tempCustomers.retainWhere(
        (element) {
          String textElement = element.name.toLowerCase();
          return textElement.startsWith(textFilter);
        },
      );
    }

    emit(CustomerQueryStateRefreshList(tempCustomers));
  }
}
