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
    try {
      var repository = CustomerRepository.instance;
      var snapshot = repository.getFireCloud.snapshots();

      await snapshot.forEach((element) async {
        print("** buscando dados dos clientes async (CustomerQueryBloc)");
        _customers.clear();

        for (var doc in element.docs) {
          Customer customer = Customer.fromJson(doc.data(), doc.id);
          _customers.add(customer);
        }
        // delay to avoid strange behavior on the screen
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
