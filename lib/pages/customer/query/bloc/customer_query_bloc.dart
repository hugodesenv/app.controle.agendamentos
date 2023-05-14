import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:bloc/bloc.dart';

class CustomerQueryBloc extends Bloc<CustomerQueryEvent, CustomerQueryState> {
  CustomerQueryBloc(super.initialState) {
    on<CustomerQueryEventFetchAll>(fetchAll);
    on<CustomerQueryEventNew>((_, emit) => emit(CustomerQueryStateOpenNew()));
    on<CustomerQueryEventImport>((_, emit) => emit(CustomerQueryStateOpenImport()));
  }

  void fetchAll(event, emit) async {
    emit(CustomerQueryStateLoading());

    List<Customer> customers = [
      Customer(name: "André", cellphone: '19 9 8961-5184'),
      Customer(name: "Carlos"),
      Customer(name: "Cléo"),
      Customer(name: "Cecília"),
      Customer(name: "Hugo"),
      Customer(name: "Maria"),
      Customer(name: "Marry Jane"),
      Customer(name: "Otávio"),
      Customer(name: "Luan"),
      Customer(name: "Zette"),
    ];

    emit(CustomerQueryStateLoaded(customers: customers));
  }
}
