abstract class CustomerInfoEvent {}

class CustomerInfoEventOpenWhatsApp extends CustomerInfoEvent {
  final String? _number;

  CustomerInfoEventOpenWhatsApp(this._number);

  String get number => _number ?? '';
}

class CustomerInfoEventDelete extends CustomerInfoEvent {}
