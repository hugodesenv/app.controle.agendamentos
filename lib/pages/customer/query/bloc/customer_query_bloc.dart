import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerQueryBloc extends Bloc<CustomerQueryEvent, CustomerQueryState> {
  //it is necessary to filter the data in the field
  final List<Customer> _customers = [];

  CustomerQueryBloc(super.initialState) {
    on<CustomerQueryEventFetchAll>(_fetchAll);
    on<CustomerQueryEventOnChangedFilter>(_changedFilter);
  }

  void _fetchAll(event, emit) async {
    emit(CustomerQueryStateLoading(true));
    try {
      var repository = CustomerRepository.instance;

      await repository.fetchStream((callbackCustomers) async {
        _customers.clear();
        _customers.addAll(callbackCustomers);
        await Future.delayed(const Duration(seconds: 1), () async => emit(CustomerQueryStateRefreshList(_customers)));
      });
    } finally {
      emit(CustomerQueryStateLoading(false));
    }
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
