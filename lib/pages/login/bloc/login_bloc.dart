import 'package:agendamentos/pages/login/bloc/login_event.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:agendamentos/repository/api/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState) {
    on<LoginEventSubmitted>(_loginSubmitted);
    on<LoginEventVerifyAuthentication>(_verifyAuthentication);
    on<LoginEventShowModal>(_showModal);
  }

  _loginSubmitted(LoginEventSubmitted event, emit) async {
    emit(LoginStateLoading());

    if (event.email.isEmpty) {
      emit(LoginStateFailure(message: 'E-mail é obrigatório!'));
      return;
    }

    if (event.password.isEmpty) {
      emit(LoginStateFailure(message: 'Campo senha é obrigatório!'));
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(LoginStateSuccess());
    } catch (e) {
      emit(LoginStateFailure(message: 'Falha de autenticação, verifique suas credenciais!'));
    }
  }

  Future<void> _verifyAuthentication(LoginEventVerifyAuthentication event, emit) async {
    emit(LoginStateSplash());
    await Future.delayed(const Duration(seconds: 2));

    UserRepository repository = UserRepository();
    bool isAuth = await repository.isAuthenticated();

    if (isAuth) {
      emit(LoginStateSuccess());
    } else {
      emit(LoginStateInitial());
    }
  }

  _showModal(LoginEventShowModal event, emit) {
    emit(LoginStateShowModal(event.enModal));
  }
}
