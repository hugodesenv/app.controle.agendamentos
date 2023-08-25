import 'package:agendamentos/assets/constants/stringConstants.dart';
import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/api/user_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(super.initialState) {
    on<SignInEventSubmitted>(_signIn);
    on<SignInEventAuthenticated>(_directHome);
    on<SignInEventSubmittedForgetPassword>(_resetPassword);
  }

  Future<void> _signIn(SignInEventSubmitted event, emit) async {
    String username = event.username;
    String password = event.password;

    if (username.isEmpty) {
      emit(SignInStateFailure('Usuário inválido!'));
      return;
    }

    if (password.isEmpty) {
      emit(SignInStateFailure('Senha inválida!'));
      return;
    }

    try {
      emit(SignInStateLoading());

      Account res = await UserRepository.instance.signIn(username, password);
      if (res.username.isEmpty) {
        emit(SignInStateFailure('Usuário ou senha incorretos!'));
        return;
      }

      emit(SignInStateSuccess());
    } catch (e) {
      emit(SignInStateFailure(e.toString()));
    }
  }

  Future<void> _directHome(_, emit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString(SHARED_PREFERENCES_USER_SESSION);
    user != null ? emit(SignInStateGoToHome()) : emit(SignInStateInitial());
  }

  Future<void> _resetPassword(SignInEventSubmittedForgetPassword event, emit) async {
    emit(SignInStateWaitingEmailReset());

    UserRepository repository = UserRepository.instance;
    try {
      await repository.resetEmailPassword(event.email);
      emit(
        SignInStateResetPassword(
            emailSent: true,
            message: 'E-mail de redefinição de senha '
                'encaminhado para ${event.email}'),
      );
    } catch (e) {
      emit(
        SignInStateResetPassword(
            emailSent: false,
            message: 'Falha ao transmitir e-mail de redefinição de senha. Confira se o '
                'seu e-mail está correto ou tente novamente mais tarde!'),
      );
    }
  }
}
