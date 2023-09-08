import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/pages/home/bloc/home_event.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/repository/api/user_repository.dart';
import 'package:bloc/bloc.dart';

import '../../../repository/classes/preferences_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<HomeEventInitial>(_initial);
    on<HomeEventSignOut>(_signOut);
    on<HomeEventsScheduleListener>(_handleTotals);
  }

  Future<void> _initial(_, emit) async {
    Account userSession = await PreferencesRepository.getPrefsCurrentUser();
    emit(state.copyWith(accountConnected: userSession));
  }

  Future<void> _signOut(HomeEventSignOut event, emit) async {
    UserRepository repository = UserRepository.instance;
    if (await repository.signOut()) {
      emit(state.copyWith(isLoggedOut: true));
    }
  }

  _handleTotals(HomeEventsScheduleListener event, emit) {
    emit(state.copyWith(totals: event.totals));
  }
}
