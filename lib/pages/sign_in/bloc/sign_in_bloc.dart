import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:bloc/bloc.dart';

import '../../../repository/api/user_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(super.initialState) {
    on<SignInEventSubmitted>(_signIn);
    on<SignInEventAuthenticated>(_autoDirectHome);
  }

  Future<void> _signIn(SignInEventSubmitted event, emit) async {
    String email = event.email;
    String password = event.password;

    if (email.isEmpty) {
      emit(SignInStateFailure('E-mail inválido!'));
      return;
    }

    if (password.isEmpty) {
      emit(SignInStateFailure('Senha inválida!'));
      return;
    }

    try {
      emit(SignInStateLoading());
      await UserRepository.instance.signInEmailPassword(email, password);
      emit(SignInStateSuccess());
    } catch (e) {
      emit(SignInStateFailure('Falha de autenticação, verifique suas credenciais!'));
    }
  }

  Future<void> _autoDirectHome(_, emit) async {
    UserRepository repository = UserRepository.instance;
    bool authenticated = await repository.isAuthenticated();
    authenticated ? emit(SignInStateGoToHome()) : emit(SignInStateInitial());
  }

  Future<void> _resetPassword(event, emit) async {
    //emit(LoginStateLoading(EnLoginLoading.tpForgetPassword));

    String email = event.email;
    UserRepository repository = UserRepository.instance;
    try {
      await repository.resetEmailPassword(email);
      //emit(
      //  LoginStateSuccessResetEmail(
      //      message: 'E-mail enviado com sucesso para ${email}! '
      //          'Confira sua caixa de mensagens e prossiga com a alteração de senha'),
      //);
    } catch (e) {
      //emit(LoginStateFailureResetEmail(
      //    message: 'Não foi possível encaminhar o e-mail de redefinição. Confira se o seu e-mail está correto ou,'
      //        ' tente novamente mais tarde!'));
    }
  }
}
