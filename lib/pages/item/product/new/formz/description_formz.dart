import 'package:formz/formz.dart';

enum DescriptionValidationError { empty }

class DescriptionFormz extends FormzInput<String, DescriptionValidationError> {
  const DescriptionFormz.pure() : super.pure('');

  const DescriptionFormz.dirty({String value = ''}) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String value) {
    if (value.isEmpty) {
      return DescriptionValidationError.empty;
    }
    return null;
  }
}

extension DescriptionValidationErrorText on DescriptionValidationError {
  String text() {
    switch (this) {
      case DescriptionValidationError.empty:
        return 'Informe a descrição do produto';
    }
  }
}
