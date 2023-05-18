import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerQueryBloc extends Bloc<CustomerQueryEvent, CustomerQueryState> {
  List<Customer> customers = [];

  CustomerQueryBloc(super.initialState) {
    on<CustomerQueryEventFetchAll>(fetchAll);
    on<CustomerQueryEventRemoveFromList>(removeFromList);
    on<CustomerQueryEventOpen>((event, emit) => emit(CustomerQueryStateOpen(event.typeOpen)));
  }

  void fetchAll(event, emit) async {
    emit(CustomerQueryStateLoading(true));

    var repository = CustomerRepository.instance;
    customers = await repository.fetchData();

    emit(CustomerQueryStateRefresh());
  }

  void removeFromList(event, emit) {
    emit(CustomerQueryStateLoading(true));
    customers.remove(event.customer);
    emit(CustomerQueryStateLoading(false));
  }
}
