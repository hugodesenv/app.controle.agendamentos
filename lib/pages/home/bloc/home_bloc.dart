import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/pages/home/bloc/home_event.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/repository/api/user_repository.dart';
import 'package:agendamentos/widgets/sf_calendar_schedules/model/schedules_model.dart';
import 'package:bloc/bloc.dart';

import '../../../repository/api/schedule_repository.dart';
import '../../../repository/classes/preferences_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<HomeEventInitial>(_initial);
    on<HomeEventSignOut>(_signOut);
    on<HomeEventFindSchedules>(_findSchedules);
  }

  Future<void> _initial(_, emit) async {
    Account userSession = await PreferencesRepository.getPrefsCurrentUser();
    emit(state.copyWith(accountConnected: userSession));
    add(HomeEventFindSchedules());
  }

  Future<void> _signOut(HomeEventSignOut event, emit) async {
    UserRepository repository = UserRepository.instance;
    if (await repository.signOut()) {
      emit(state.copyWith(isLoggedOut: true));
    }
  }

  _findSchedules(HomeEventFindSchedules event, emit) async {
    emit(state.copyWith(refreshSchedules: true));
  }
}
