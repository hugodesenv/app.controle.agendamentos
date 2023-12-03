import '../../../../enum/formulario_estado_enum.dart';
import '../formz/model.dart';

class CustomerNewState {
  final NameFormz name;
  final CellphoneFormz cellphone;
  final bool isValid;
  final FormularioEstado status;
  final String message;

  CustomerNewState({
    NameFormz? name,
    CellphoneFormz? cellphone,
    this.isValid = false,
    this.status = FormularioEstado.INICIAL,
    this.message = '',
  })  : name = name ?? NameFormz.pure(),
        cellphone = cellphone ?? CellphoneFormz.pure();

  CustomerNewState copyWith({
    FormularioEstado? status,
    NameFormz? name,
    CellphoneFormz? cellphone,
    bool? isValid,
    String? message,
  }) {
    return CustomerNewState(
      status: status ?? this.status,
      name: name ?? this.name,
      cellphone: cellphone ?? this.cellphone,
      isValid: isValid ?? this.isValid,
      message: message ?? '',
    );
  }
}
