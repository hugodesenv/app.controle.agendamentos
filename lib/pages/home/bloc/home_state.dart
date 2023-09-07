import '../../../models/account.dart';

class HomeState {
  final Account accountConnected;
  final bool isLoggedOut;

  HomeState({
    accountConnected,
    isLoggedOut,
  })  : accountConnected = accountConnected ?? Account.empty(),
        isLoggedOut = isLoggedOut ?? false;

  HomeState copyWith({
    Account? accountConnected,
    bool? isLoggedOut,
  }) {
    return HomeState(
      accountConnected: accountConnected ?? this.accountConnected,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }
}

class HomeStateInitial extends HomeState {}
