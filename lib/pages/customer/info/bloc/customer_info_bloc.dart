import 'package:agendamentos/enum/formulario_estado_enum.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:agendamentos/utils/launcher_util.dart';
import 'package:bloc/bloc.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  CustomerInfoBloc(super.initialState) {
    on<CustomerInfoEventOpenWhatsApp>(_openWhatsApp);
    on<CustomerInfoEventDelete>(_delete);
  }

  Future _openWhatsApp(CustomerInfoEventOpenWhatsApp event, emit) async {
    try {
      emit(state.copyWith(status: FormularioEstado.EM_PROGRESSO));

      LauncherUtils repository = LauncherUtils.instance;
      await repository.launchWhatsApp(event.number);

      emit(state.copyWith(status: FormularioEstado.SUCESSO));
    } catch (e) {
      emit(state.copyWith(
        status: FormularioEstado.FALHA,
        message: 'Não foi possível abrir o WhatsApp',
      ));
    }
  }

  Future _delete(event, emit) async {
    emit(state.copyWith(status: FormularioEstado.EM_PROGRESSO));
    try {
      var repository = CustomerRepository.instance;
      Map res = await repository.delete(state.customer.id);

      if (res['success'] == true) {
        emit(state.copyWith(
          status: FormularioEstado.EXCLUIDO,
          message: res["message"],
        ));
      } else {
        emit(state.copyWith(
          status: FormularioEstado.FALHA,
          message: res["message"],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: FormularioEstado.FALHA,
        message: 'Falha: ${e.toString()}',
      ));
    }
  }
}
