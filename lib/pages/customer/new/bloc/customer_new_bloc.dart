import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class CustomerNewBloc extends Bloc<CustomerNewEvent, CustomerNewState> {
  final _formKeyMain = GlobalKey<FormState>();
  Customer _customer = Customer.empty();

  CustomerNewBloc(super.initialState, {required arguments}) {
    print("* oi");
    on<CustomerNewEventSubmitted>(_submitted);
    on<CustomerNewEventOnChanged>(_onChanged);
    on<CustomerNewEventEditMode>(_editMode);

  }

  get formKeyMain => _formKeyMain;

  Customer get customer => _customer;

  Future _submitted(CustomerNewEventSubmitted event, emit) async {
    bool isValid = _formKeyMain.currentState!.validate();

    if (isValid) {
      var repository = CustomerRepository.instance;
      _customer.id = await repository.save(_customer);
      emit(CustomerNewStateSuccess(_customer));
    }
  }

  _onChanged(CustomerNewEventOnChanged event, emit) {
    _customer = _customer.copyWith(
      name: event.name,
      cellphone: event.cellphone,
    );
  }

  _editMode(event, emit) {
    _customer = event.customer;
    emit(CustomerNewStateLoaded());
  }
}
