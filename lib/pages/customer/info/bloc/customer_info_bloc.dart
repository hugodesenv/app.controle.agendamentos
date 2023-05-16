import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/repository/launcher_repository.dart';
import 'package:bloc/bloc.dart';
import '../../../../model/customer.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  Customer? customer;

  CustomerInfoBloc(super.initialState, this.customer) {
    on<CustomerInfoEventOpenWhatsApp>(_openWhatsApp);
  }

  Future _openWhatsApp(CustomerInfoEventOpenWhatsApp event, emit) async {
    emit(CustomerInfoStateLoadingWhatsApp(true));
    try {
      LauncherRepository repository = LauncherRepository.instance;
      bool opened = await repository.launchWhatsApp(event.number);
      if (opened == false) {
        emit(CustomerInfoStateWhatsAppFailure('Ops, não foi possível abrir o WhatsApp! Verifique se ele está instalado!'));
      }
    } finally {
      emit(CustomerInfoStateLoadingWhatsApp(false));
    }
  }
}