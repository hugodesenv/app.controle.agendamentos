import 'package:agendamentos/models/customer.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/pages/customer/new/formz/model.dart';
import 'package:agendamentos/utils/preferences_util.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import '../../../../enum/formulario_estado_enum.dart';
import '../../../../repository/customer_repository.dart';

class CustomerNewBloc extends Bloc<CustomerNewEvent, CustomerNewState> {
  Customer _customer = Customer.empty();

  CustomerNewBloc(Customer customer, super.initialState) {
    _customer = customer;
    on<CustomerNewEventNameChanged>(_nameChanged);
    on<CustomerNewEventCellphoneChanged>(_cellphoneChanged);
    on<CustomerNewEventSubmitted>(_submitted);
  }

  _nameChanged(CustomerNewEventNameChanged event, emit) {
    _customer = _customer.copyWith(name: event.name);

    emit(state.copyWith(
      name: NameFormz.dirty(value: _customer.name),
    ));
  }

  _cellphoneChanged(CustomerNewEventCellphoneChanged event, emit) {
    _customer = _customer.copyWith(cellphone: event.cellphone);

    emit(state.copyWith(
      cellphone: CellphoneFormz.dirty(value: _customer.cellphone),
    ));
  }

  Future _submitted(CustomerNewEventSubmitted event, emit) async {
    // validating if the fields is correct
    emit(state.copyWith(
      status: FormularioEstado.INICIAL,
      isValid: Formz.validate([
        state.name,
        state.cellphone,
      ]),
    ));

    if (state.isValid) {
      emit(state.copyWith(status: FormularioEstado.EM_PROGRESSO));
      try {
        var res = {};
        CustomerRepository repository = CustomerRepository.instance;

        if (_customer.id.isEmpty) {
          _customer.empresa = (await PreferencesUtil.usuarioAtual()).empresa;
          res = await repository.save(_customer);
        } else {
          res = await repository.update(_customer);
        }

        var formStatus = res['success'] == true
            ? FormularioEstado.SUCESSO
            : FormularioEstado.FALHA;
        emit(state.copyWith(status: formStatus, message: res['message']));
      } catch (e) {
        emit(state.copyWith(
          status: FormularioEstado.FALHA,
          message: 'Falha: ${e.toString()}',
        ));
      }
    } else {
      emit(state.copyWith(
        status: FormularioEstado.FALHA,
        message: 'Não é possível gravar, confira os campos obrigatórios',
      ));
    }
  }
}
