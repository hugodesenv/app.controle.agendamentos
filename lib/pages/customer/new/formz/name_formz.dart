import 'package:formz/formz.dart';

enum NameValidationError { empty, tooShort }

class NameFormz extends FormzInput<String, NameValidationError> {
  NameFormz.dirty({String value = ''}) : super.dirty(value);

  NameFormz.pure() : super.pure('');

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    }

    if (value.length < 3) {
      return NameValidationError.tooShort;
    }

    return null;
  }
}

// extension on serve para adicionar métodos adicionais aos enumerados.
extension NameValidationErrorText on NameValidationError {
  String text() {
    switch (this) {
      case NameValidationError.empty:
        return 'O nome não pode estar vazio';
      case NameValidationError.tooShort:
        return 'O nome deve ter ao menos 3 caracteres';
    }
  }
}
