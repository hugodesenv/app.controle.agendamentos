import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/repository/api/customer_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerQueryBloc extends Bloc<CustomerQueryEvent, CustomerQueryState> {
  //it is necessary to filter the data in the field
  final List<Customer> _customers = [];

  CustomerQueryBloc(super.initialState) {
    on<CustomerQueryEventFetchAll>(_fetchAll);
    on<CustomerQueryEventOnChangedFilter>(_changedFilter);
    on<CustomerQueryEventUpdated>(_customersUpdated);
  }

  @override
  Future<void> close() {
    CustomerRepository.instance.subscription?.cancel();
    return super.close();
  }

  Future _customersUpdated(CustomerQueryEventUpdated event, emit) async {
    await Future.delayed(
      const Duration(seconds: 1),
      () async => emit(CustomerQueryStateRefreshList(event.customers)),
    );
  }

  void _fetchAll(event, emit) async {
    CustomerRepository repository = CustomerRepository.instance;
    List<Customer> res = await repository.findAll();

    _customers.clear();
    _customers.addAll(res);

    add(CustomerQueryEventUpdated(customers: _customers));
  }

  void _changedFilter(CustomerQueryEventOnChangedFilter event, emit) {
    String textFilter = event.value;
    List<Customer> tempCustomers = [];
    tempCustomers.addAll(_customers);

    if (textFilter.isNotEmpty) {
      tempCustomers.retainWhere(
        (element) {
          String textElement = element.name.toLowerCase();
          return textElement.contains(textFilter);
        },
      );
    }

    emit(CustomerQueryStateRefreshList(tempCustomers));
  }
}
