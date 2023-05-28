import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerQueryBloc extends Bloc<CustomerQueryEvent, CustomerQueryState> {
  final List<Customer> _customers = [];

  CustomerQueryBloc(super.initialState) {
    on<CustomerQueryEventFetchAll>(_fetchAll);
    on<CustomerQueryEventOnChangedFilter>(_changedFilter);
  }

  void _fetchAll(event, emit) async {
    emit(CustomerQueryStateLoading(true));

    var repository = CustomerRepository.instance;

    _customers.clear();
    _customers.addAll(await repository.fetchData());

    emit(CustomerQueryStateRefreshList(_customers));
  }

  void _changedFilter(CustomerQueryEventOnChangedFilter event, emit) {
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
