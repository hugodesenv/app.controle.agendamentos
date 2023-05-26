import '../../../../model/arguments/argsCustomerInfo.dart';

abstract class CustomerInfoEvent {}

class CustomerInfoEventInitial extends CustomerInfoEvent {}

class CustomerInfoEventDelete extends CustomerInfoEvent {}

class CustomerInfoEventOpenWhatsApp extends CustomerInfoEvent {
  final String? _number;

  CustomerInfoEventOpenWhatsApp(this._number);

  String get number => _number ?? '';
}
