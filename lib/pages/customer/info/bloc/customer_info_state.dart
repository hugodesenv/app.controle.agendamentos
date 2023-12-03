import '../../../../enum/formulario_estado_enum.dart';
import '../../../../models/customer.dart';

class CustomerInfoState {
  final Customer customer;
  final FormularioEstado status;
  final String? message;

  CustomerInfoState({
    required Customer? customer,
    this.status = FormularioEstado.INICIAL,
    this.message = '',
  }) : customer = customer ?? Customer.empty();

  CustomerInfoState copyWith({
    Customer? customer,
    FormularioEstado? status,
    String? message,
  }) {
    return CustomerInfoState(
      customer: customer ?? this.customer,
      status: status ?? this.status,
      message: message ?? '',
    );
  }
}
