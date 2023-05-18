import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/repository/customer_repository.dart';
import 'package:agendamentos/repository/launcher_repository.dart';
import 'package:bloc/bloc.dart';
import '../../../../model/customer.dart';

class CustomerInfoBloc extends Bloc<CustomerInfoEvent, CustomerInfoState> {
  Customer? customer;

  CustomerInfoBloc(super.initialState, this.customer) {
    on<CustomerInfoEventOpenWhatsApp>(_openWhatsApp);
    on<CustomerInfoEventDelete>(_delete);
  }

  Future _openWhatsApp(CustomerInfoEventOpenWhatsApp event, emit) async {
    emit(CustomerInfoStateLoading(true));

    LauncherRepository repository = LauncherRepository.instance;
    bool res = await repository.launchWhatsApp(event.number);

    res
        ? emit(CustomerInfoStateLoading(false))
        : emit(CustomerInfoStateFailure(
            'Ops, não foi possível abrir o WhatsApp! Verifique se ele está instalado!'));
  }

  Future _delete(event, emit) async {
    var repository = CustomerRepository.instance;
    bool res = await repository.delete(customer!.id);
    res
        ? emit(CustomerInfoStateSuccess('Cliente excluído com sucesso!', TypeSuccess.tpDelete))
        : emit(CustomerInfoStateFailure('Houve uma falha na exclusão do cliente...'));
  }
}
