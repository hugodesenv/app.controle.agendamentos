import 'package:formz/formz.dart';

enum CellphoneValidationError { none }

class CellphoneFormz extends FormzInput<String, CellphoneValidationError> {
  CellphoneFormz.dirty({String value = ''}) : super.dirty(value);

  CellphoneFormz.pure() : super.pure('');

  @override
  CellphoneValidationError? validator(String value) {
    return null;
  }
}

extension CellphoneValidationErrorText on CellphoneValidationError {
  text() {
    switch (this) {
      case CellphoneValidationError.none:
        break;
    }
  }
}
