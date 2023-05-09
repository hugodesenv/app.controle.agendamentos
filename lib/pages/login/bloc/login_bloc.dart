import 'package:agendamentos/pages/login/bloc/login_event.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState) {
    on<LoginSubmitted>(_loginSubmitted);
  }

  _loginSubmitted(LoginSubmitted event, emit) async {
    emit(LoginLoading());

    if (event.username.isEmpty) {
      emit(LoginFailure(message: 'Campo usuário é obrigatório!'));
      return;
    }

    if (event.password.isEmpty) {
      emit(LoginFailure(message: 'Campo senha é obrigatório!'));
      return;
    }

    if (event.username != 'hugo') {
      emit(LoginFailure(message: 'Usuário ou senha incorretos!'));
      return;
    }

    await Future.delayed(const Duration(seconds: 2), () => emit(LoginSuccess()));
  }
}
