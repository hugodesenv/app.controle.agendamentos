import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:bloc/bloc.dart';

class CustomerRegisterBloc extends Bloc<CustomerNewEvent, CustomerNewState> {
  CustomerRegisterBloc(super.initialState) {}
}
