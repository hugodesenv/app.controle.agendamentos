import 'package:agendamentos/models/schedule.dart';
import '../../../models/account.dart';

class HomeState {
  final Account accountConnected;
  final List<Schedule> schedules;
  final bool isLoggedOut;

  HomeState({
    schedules,
    accountConnected,
    isLoggedOut,
  })  : schedules = schedules ?? [],
        accountConnected = accountConnected ?? Account.empty(),
        isLoggedOut = isLoggedOut ?? false;

  HomeState copyWith({
    List<Schedule>? schedules,
    Account? accountConnected,
    bool? isLoggedOut,
  }) {
    return HomeState(
      schedules: schedules ?? this.schedules,
      accountConnected: accountConnected ?? this.accountConnected,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }
}

class HomeStateInitial extends HomeState {}
