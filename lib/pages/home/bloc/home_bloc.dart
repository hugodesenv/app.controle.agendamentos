import 'package:agendamentos/pages/home/bloc/home_event.dart';
import 'package:agendamentos/pages/home/bloc/home_state.dart';
import 'package:agendamentos/repository/user_repository.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<HomeEventInitial>(_initial);
    on<HomeEventSignOut>(_signOut);
  }

  Future<void> _initial(_, emit) async {
    var userRepository = UserRepository.instance;

    var id = userRepository.currentUser?.uid ?? '';
    await userRepository.startSession(id);

    emit(HomeStateRefreshUser(login: userRepository.currentLogin));
  }

  Future<void> _signOut(HomeEventSignOut event, emit) async {
    UserRepository repository = UserRepository.instance;
    await repository.signOut();
    emit(HomeStateSignOut());
  }
}
