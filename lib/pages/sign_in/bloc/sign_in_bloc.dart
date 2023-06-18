import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../repository/user_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(super.initialState) {
    on<SignInEventSubmitted>(_signIn);
    on<SignInEventAuthenticated>(_directHome);
    on<SignInEventSubmittedForgetPassword>(_resetPassword);
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

  Future<void> _directHome(_, emit) async {
    var user = FirebaseAuth.instance.currentUser;
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
