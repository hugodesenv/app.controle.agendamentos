import 'package:agendamentos/model/arguments/args_customer_new.dart';
import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class CustomerNewBloc extends Bloc<CustomerNewEvent, CustomerNewState> {
  final _formKeyMain = GlobalKey<FormState>();
  ArgsCustomerNew arguments;

  CustomerNewBloc(super.initialState, {required this.arguments}) {
    on<CustomerNewEventSubmitted>(_submitted);
    on<CustomerNewEventOnChanged>(_onChanged);
    on<CustomerNewEventEditMode>(_editMode);
  }

  get formKeyMain => _formKeyMain;

  Customer get getCustomer => arguments.customer;

  set setCustomer(Customer customer) => arguments.customer = customer;

  CustomerQueryBloc get getCustomerQueryBloc => arguments.queryBloc;

  /// when the person saves the customer
  Future _submitted(CustomerNewEventSubmitted event, emit) async {
    bool isValid = _formKeyMain.currentState!.validate();

    if (isValid) {
      var repository = CustomerRepository.instance;
      getCustomer.id = await repository.save(getCustomer);
      emit(CustomerNewStateSuccess(getCustomer));
    }
  }

  ///when the field is changed
  _onChanged(CustomerNewEventOnChanged event, emit) {
    setCustomer = getCustomer.copyWith(
      name: event.name,
      cellphone: event.cellphone,
    );
  }

  ///when the screen is edit state
  _editMode(event, emit) {
    setCustomer = event.customer;
    emit(CustomerNewStateLoaded());
  }
}
