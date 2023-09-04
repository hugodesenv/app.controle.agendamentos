import 'package:agendamentos/widgets/sf_calendar_schedules/model/schedules_model.dart';

import '../../../models/account.dart';

class HomeState {
  final Account accountConnected;
  final bool refreshSchedules;
  final bool isLoggedOut;

  HomeState({
    refreshSchedules,
    accountConnected,
    isLoggedOut,
  })  : refreshSchedules = refreshSchedules ?? false,
        accountConnected = accountConnected ?? Account.empty(),
        isLoggedOut = isLoggedOut ?? false;

  HomeState copyWith({
    bool? refreshSchedules,
    Account? accountConnected,
    bool? isLoggedOut,
  }) {
    return HomeState(
      refreshSchedules: refreshSchedules ?? false,
      accountConnected: accountConnected ?? this.accountConnected,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
  }
}

class HomeStateInitial extends HomeState {}
