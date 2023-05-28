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
    on<CustomerNewEventInitial>(_initial);
  }

  get formKeyMain => _formKeyMain;

  ///when the screen open, in insert or edit mode
  _initial(CustomerNewEventInitial event, emit) {
    _customer = event.customer;
    emit(CustomerNewStateLoaded(customer: _customer));
  }

  /// when the person saves the customer!
  Future _submitted(CustomerNewEventSubmitted event, emit) async {
    bool isValid = _formKeyMain.currentState!.validate();

    if (isValid) {
      try {
        var repository = CustomerRepository.instance;
        _customer.id = await repository.save(_customer);
        emit(CustomerNewStateSuccess(_customer, 'Processo realizado com sucesso!'));
      } catch (e) {
        emit(CustomerNewStateFailure('Houve uma falha ao gravar, tente novamente!'));
      }
    }
  }

  ///when the field is changed
  _onChanged(CustomerNewEventOnChanged event, emit) {
    _customer = _customer.copyWith(
      name: event.name,
      cellphone: event.cellphone,
    );
  }
}
