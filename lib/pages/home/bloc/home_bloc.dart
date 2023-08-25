import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/pages/home/bloc/home_event.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/repository/api/user_repository.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<HomeEventInitial>(_initial);
    on<HomeEventSignOut>(_signOut);
  }

  Future<void> _initial(_, emit) async {
    Account userSession = await UserRepository.instance.getCurrentUser();
    emit(HomeStateRefreshUser(accountConnected: userSession));
  }

  Future<void> _signOut(HomeEventSignOut event, emit) async {
    UserRepository repository = UserRepository.instance;
    if (await repository.signOut()) {
      emit(HomeStateSignOut());
    }
  }
}
