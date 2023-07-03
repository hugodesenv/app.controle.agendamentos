import 'package:agendamentos/assets/enum/form_submission_status.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/repository/api/customer_repository.dart';
import 'package:agendamentos/repository/classes/launcher_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  CustomerInfoBloc(super.initialState) {
    on<CustomerInfoEventOpenWhatsApp>(_openWhatsApp);
    on<CustomerInfoEventDelete>(_delete);
  }

  Future _openWhatsApp(CustomerInfoEventOpenWhatsApp event, emit) async {
    try {
      emit(state.copyWith(status: FormSubmissionStatus.inProgress));

      LauncherRepository repository = LauncherRepository.instance;
      await repository.launchWhatsApp(event.number);

      emit(state.copyWith(status: FormSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: FormSubmissionStatus.failure,
        message: 'Não foi possível abrir o WhatsApp',
      ));
    }
  }

  Future _delete(event, emit) async {
    emit(state.copyWith(status: FormSubmissionStatus.inProgress));
    try {
      var repository = CustomerRepository.instance;
      bool res = await repository.delete(state.customer.id ?? '');
      if (res) {
        emit(state.copyWith(
          status: FormSubmissionStatus.deleted,
          message: 'Cliente excluído com sucesso!',
        ));
      } else {
        emit(state.copyWith(
          status: FormSubmissionStatus.failure,
          message: 'Não foi possível excluir o cliente, verifique e tente novamente!',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: FormSubmissionStatus.failure,
        message: 'Falha: ${e.toString()}',
      ));
    }
  }
}
