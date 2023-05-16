abstract class CustomerInfoState {}

class CustomerInfoStateInitial extends CustomerInfoState {}

class CustomerInfoStateLoadingWhatsApp extends CustomerInfoState {
  final bool _isLoading;

  CustomerInfoStateLoadingWhatsApp(this._isLoading);

  bool get isLoading => _isLoading;
}

class CustomerInfoStateWhatsAppFailure extends CustomerInfoState {
  final String _message;

  CustomerInfoStateWhatsAppFailure(this._message);

  String get message => _message;
}
