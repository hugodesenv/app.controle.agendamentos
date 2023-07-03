import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/pages/customer/new/formz/model.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import '../../../../assets/enum/form_submission_status.dart';
import '../../../../repository/api/customer_repository.dart';

class CustomerNewBloc extends Bloc<CustomerNewEvent, CustomerNewState> {
  CustomerNewBloc(super.initialState) {
    on<CustomerNewEventNameChanged>(_nameChanged);
    on<CustomerNewEventCellphoneChanged>(_cellphoneChanged);
    on<CustomerNewEventSubmitted>(_submitted);
  }

  _nameChanged(CustomerNewEventNameChanged event, emit) {
    final name = NameFormz.dirty(value: event.name);
    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([name, state.cellphone]),
    ));
  }

  _cellphoneChanged(CustomerNewEventCellphoneChanged event, emit) {
    final cellphone = CellphoneFormz.dirty(value: event.cellphone);
    emit(
      state.copyWith(
        cellphone: cellphone,
        isValid: Formz.validate([state.name, cellphone]),
      ),
    );
  }

  Future _submitted(CustomerNewEventSubmitted event, emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormSubmissionStatus.inProgress));
      try {
        var repository = CustomerRepository.instance;

        await repository.save(Customer(
          id: state.id,
          name: state.name.value,
          cellphone: state.cellphone.value,
        ));

        emit(state.copyWith(
          status: FormSubmissionStatus.success,
          message: 'Cliente gravado com sucesso!',
        ));
      } catch (e) {
        emit(state.copyWith(
          status: FormSubmissionStatus.failure,
          message: 'Falha: ${e.toString()}',
        ));
      }
    }
  }
}
