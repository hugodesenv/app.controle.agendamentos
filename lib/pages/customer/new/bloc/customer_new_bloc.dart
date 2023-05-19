import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class CustomerNewBloc extends Bloc<CustomerNewEvent, CustomerNewState> {
  final _formKeyMain = GlobalKey<FormState>();
  Customer _customer = Customer.empty();

  CustomerNewBloc(super.initialState) {
    on<CustomerNewEventSubmitted>(_submitted);
    on<CustomerNewEventOnChanged>(_onChanged);
  }

  get formKeyMain => _formKeyMain;

  get customer => _customer;

  Future _submitted(CustomerNewEventSubmitted event, emit) async {
    bool isValid = _formKeyMain.currentState!.validate();

    if (isValid) {
      var repository = CustomerRepository.instance;
      _customer.id = await repository.save(_customer);
      emit(CustomerNewStateSuccess());
    }
  }

  _onChanged(CustomerNewEventOnChanged event, emit) {
    _customer = _customer.copyWith(
      name: event.name,
      cellphone: event.cellphone,
    );
  }
}
