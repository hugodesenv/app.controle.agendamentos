import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class CustomerNewBloc extends Bloc<CustomerNewEvent, CustomerNewState> {
  final _formKeyMain = GlobalKey<FormState>();
  late Customer _customer;

  CustomerNewBloc(super.initialState) {
    on<CustomerNewEventSubmitted>(_submitted);
    on<CustomerNewEventOnChanged>(_onChanged);
    on<CustomerNewEventEditMode>(_editMode);
  }

  get formKeyMain => _formKeyMain;

  Customer get getCustomer => _customer;

  set customer(Customer value) {
    _customer = value;
  }

  /// when the person saves the customer
  Future _submitted(CustomerNewEventSubmitted event, emit) async {
    bool isValid = _formKeyMain.currentState!.validate();

    if (isValid) {
      try {
        var repository = CustomerRepository.instance;
        getCustomer.id = await repository.save(getCustomer);
        emit(CustomerNewStateSuccess(getCustomer, 'Cliente cadastrado com sucesso!'));
      } catch (e) {
        emit(CustomerNewStateFailure('Não foi possível cadastrar o cliente, tente novamente!'));
      }
    }
  }

  ///when the field is changed
  _onChanged(CustomerNewEventOnChanged event, emit) {
    customer = getCustomer.copyWith(
      name: event.name,
      cellphone: event.cellphone,
    );
  }

  ///when the screen is edit state
  _editMode(event, emit) {
    customer = event.customer;
    emit(CustomerNewStateLoaded());
  }
}
