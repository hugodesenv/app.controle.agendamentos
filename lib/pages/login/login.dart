import 'package:agendamentos/pages/login/bloc/login_bloc.dart';
import 'package:agendamentos/pages/login/bloc/login_event.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:agendamentos/repository/enums/en_login_modal.dart';
import 'package:agendamentos/routes.dart';
import 'package:agendamentos/widgets/button/my_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/text_field/my_login_text_field.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget splashScreen(context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Skedol',
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 80, top: 5),
            child: Text(
              "Seus compromissos num só lugar! :)",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.indigo),
            ),
          ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Future<void> showModalForgetPassword(pcontext) async {
    await showModalBottomSheet(
      context: pcontext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              left: 30,
              right: 30,
              top: 30,
            ),
            child: Column(
              children: [
                const Text(
                  'Digite o seu e-mail e clique no botão p/ enviar a redefinição de senha:',
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: MyLoginTextField(labelText: 'E-mail'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: MyLoadingButton(onPressed: () {}, title: 'Enviar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: BlocProvider.of<LoginBloc>(context),
        listener: (BuildContext context, state) async {
          if (state is LoginStateSuccess) {
            Navigator.pushReplacementNamed(context, ROUTE_HOME);
            return;
          }

          if (state is LoginStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            return;
          }

          if (state is LoginStateShowModal) {
            switch (state.enModal) {
              case EnModalLogin.tForgetPassword:
                await showModalForgetPassword(context);
                break;
            }
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<LoginBloc>(context),
          builder: (BuildContext context, state) {
            if (state is LoginStateSplash) {
              return splashScreen(context);
            }

            bool loading = state is LoginStateLoading;
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 40, right: 40),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Skedol',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MyLoginTextField(
                            labelText: 'E-mail', controller: emailController, autoFocus: true),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: MyLoginTextField(
                            labelText: 'Senha',
                            controller: passwordController,
                            isPassword: true,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginEventShowModal(enModal: EnModalLogin.tForgetPassword));
                          },
                          style: const ButtonStyle(alignment: Alignment.centerRight),
                          child: const Text('Esqueceu a senha?'),
                        ),
                      ],
                    ),
                    MyLoadingButton(
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginEventSubmitted(
                              email: emailController.text, password: passwordController.text),
                        );
                      },
                      title: 'Entrar',
                      loading: loading,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "2023 - Hugo Silva",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black12, fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
