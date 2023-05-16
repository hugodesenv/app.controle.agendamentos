import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  CustomerInfoBloc(super.initialState) {
    on<CustomerInfoEventOpenWhatsApp>(_openWhatsApp);
  }

  Future _openWhatsApp(CustomerInfoEventOpenWhatsApp event, emit) async {
    emit(CustomerInfoStateLoadingWhatsApp(true));
    await Future.delayed(Duration(seconds: 2));
    try {
      var whatsappUrl = 'whatsapp://send?phone=${event.number}';
      await canLaunchUrlString(whatsappUrl)
          ? launchUrlString(whatsappUrl)
          : emit(CustomerInfoStateWhatsAppFailure('Ops, não foi possível abrir o WhatsApp! Verifique se ele está instalado!'));
    } finally {
      emit(CustomerInfoStateLoadingWhatsApp(false));
    }
  }
}
