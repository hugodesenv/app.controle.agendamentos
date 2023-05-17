import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerQueryBloc extends Bloc<CustomerQueryEvent, CustomerQueryState> {
  CustomerQueryBloc(super.initialState) {
    on<CustomerQueryEventFetchAll>(fetchAll);
    on<CustomerQueryEventNew>((_, emit) => emit(CustomerQueryStateOpenNew()));
    on<CustomerQueryEventImport>((_, emit) => emit(CustomerQueryStateOpenImport()));
  }

  void fetchAll(event, emit) async {
    emit(CustomerQueryStateLoading());

    var repository = CustomerRepository.instance;
    List<Customer> customers = await repository.fetchData();
    emit(CustomerQueryStateLoaded(customers: customers));
  }
}
