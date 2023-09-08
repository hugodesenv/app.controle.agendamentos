import '../../../models/account.dart';

class HomeState {
  final Account accountConnected;
  final bool isLoggedOut;
  final Map totals;

  HomeState({
    accountConnected,
    isLoggedOut,
    totals,
  })  : accountConnected = accountConnected ?? Account.empty(),
        isLoggedOut = isLoggedOut ?? false,
        totals = totals ?? {};

  HomeState copyWith({
    Account? accountConnected,
    bool? isLoggedOut,
    Map? totals,
  }) {
    return HomeState(
      accountConnected: accountConnected ?? this.accountConnected,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
      totals: totals ?? this.totals,
    );
  }
}

class HomeStateInitial extends HomeState {}
