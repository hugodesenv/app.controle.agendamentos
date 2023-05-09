import 'package:agendamentos/pages/login/bloc/login_event.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState) {
    on<LoginSubmitted>(_doLogin);
  }

  void _doLogin(event, emit) async {
    emit(LoginLoading());
    await Future.delayed(
      const Duration(seconds: 5),
      () => emit(LoginSuccess()),
    );
  }
}
