import 'package:agendamentos/pages/login/bloc/login_event.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:agendamentos/repository/api/user_repository.dart';
import 'package:agendamentos/repository/enums/en_login_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState) {
    on<LoginEventSubmitted>(_loginSubmitted);
    on<LoginEventVerifyAuthentication>(_verifyAuthentication);
    on<LoginEventShowModal>(_showModal);
    on<LoginEventResetPassword>(_resetPassword);
  }

  _loginSubmitted(LoginEventSubmitted event, emit) async {
    emit(LoginStateLoading(EnLoginLoading.tpLogin));

    if (event.email.isEmpty) {
      emit(LoginStateFailure(message: 'E-mail é obrigatório!'));
      return;
    }

    if (event.password.isEmpty) {
      emit(LoginStateFailure(message: 'Campo senha é obrigatório!'));
      return;
    }

    try {
      await UserRepository.instance.signInEmailPassword(event.email, event.password);
      emit(LoginStateSuccess());
    } catch (e) {
      emit(LoginStateFailure(message: 'Falha de autenticação, verifique suas credenciais!'));
    }
  }

  Future<void> _verifyAuthentication(LoginEventVerifyAuthentication event, emit) async {
    emit(LoginStateSplash());
    await Future.delayed(const Duration(seconds: 4));

    UserRepository repository = UserRepository.instance;
    bool bIsAuthenticated = await repository.isAuthenticated();

    if (bIsAuthenticated) {
      emit(LoginStateSuccess());
    } else {
      emit(LoginStateInitial());
    }
  }

  _showModal(LoginEventShowModal event, emit) {
    emit(LoginStateShowModal(event.enModal));
  }

  Future<void> _resetPassword(LoginEventResetPassword event, emit) async {
    emit(LoginStateLoading(EnLoginLoading.tpForgetPassword));

    String email = event.email;
    UserRepository repository = UserRepository.instance;
    try {
      await repository.resetEmailPassword(email);
      emit(
        LoginStateSuccessResetEmail(
            message: 'E-mail enviado com sucesso para ${email}! '
                'Confira sua caixa de mensagens e prossiga com a alteração de senha'),
      );
    } catch (e) {
      emit(LoginStateFailureResetEmail(
          message: 'Não foi possível encaminhar o e-mail de redefinição. Confira se o e-mail de destino está correto ou,'
              ' tente novamente mais tarde!'));
    }
  }
}
