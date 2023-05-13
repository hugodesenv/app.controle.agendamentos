import 'package:agendamentos/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:agendamentos/routes.dart';
import 'package:agendamentos/widgets/button/my_loading_button.dart';
import 'package:agendamentos/widgets/text_field/my_login_text_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  Widget _textTitle(String title, BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Future<void> _simpleDialog(BuildContext context, String message, {bool? isError}) async {
    await AwesomeDialog(
      autoHide: const Duration(seconds: 3),
      context: context,
      dialogType: DialogType.noHeader,
      padding: const EdgeInsets.all(15),
      title: message,
      titleTextStyle: TextStyle(
        color: isError == false ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailResetController = TextEditingController();

    Future showSignIn() async {
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        isScrollControlled: true,
        builder: (_) {
          return BlocListener(
            bloc: BlocProvider.of<SignInBloc>(context),
            listener: (_, state) async {
              if (state is SignInStateSuccess) {
                Navigator.pushReplacementNamed(context, ROUTE_HOME);
              } else if (state is SignInStateFailure) {
                await _simpleDialog(context, state.message);
              } else if (state is SignInStateResetPassword) {
                await _simpleDialog(context, state.message, isError: state.emailSent == false);
              }
            },
            child: BlocBuilder(
              bloc: BlocProvider.of<SignInBloc>(context),
              builder: (_, state) {
                bool isLoading = state is SignInStateLoading;

                return Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: _textTitle('Área de acesso', context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MyLoginTextField(
                          labelText: 'E-mail',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MyLoginTextField(
                          labelText: 'Senha',
                          controller: passwordController,
                          isPassword: true,
                        ),
                      ),
                      MyLoadingButton(
                        loading: isLoading,
                        onPressed: () {
                          BlocProvider.of<SignInBloc>(context)
                              .add(SignInEventSubmitted(email: emailController.text, password: passwordController.text));
                        },
                        title: const Text('Entrar', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(alignment: Alignment.topCenter),
                        child: TextButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape:
                                  const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
                              builder: (_) {
                                return BlocBuilder(
                                  bloc: BlocProvider.of<SignInBloc>(context),
                                  builder: (_, state) {
                                    bool isLoadingReset = state is SignInStateWaitingEmailReset;
                                    if (isLoadingReset) {
                                      print("** loading reset");
                                    } else {
                                      print("** not loading reset");
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, top: 20, right: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: _textTitle('Redefinir senha', context),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: Text(
                                              'Digite o seu e-mail e clique no botão p/ enviar a redefinição de senha:',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Theme.of(context).primaryColor),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: MyLoginTextField(
                                              labelText: 'E-mail',
                                              controller: emailResetController,
                                              autoFocus: true,
                                              keyboardType: TextInputType.emailAddress,
                                            ),
                                          ),
                                          MyLoadingButton(
                                            onPressed: () => BlocProvider.of<SignInBloc>(context).add(
                                              SignInEventSubmittedForgetPassword(emailResetController.text),
                                            ),
                                            title: const Text('Enviar'),
                                            loading: isLoadingReset,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: const Text('Esqueceu sua senha?', style: TextStyle(color: Colors.black26)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      body: BlocListener(
        bloc: BlocProvider.of<SignInBloc>(context),
        listener: (_, state) {
          if (state is SignInStateGoToHome) {
            Navigator.pushReplacementNamed(context, ROUTE_HOME);
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<SignInBloc>(context),
          builder: (_, state) {
            return Container(
              //color: Colors.indigo,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo[900]!, Colors.indigoAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Skedol',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      "Seja bem-vindo(a)! \n\nOrganize e fique por dentro dos seus agendamentos! :)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: MyLoadingButton(
                      onPressed: () async => await showSignIn(),
                      colorBackground: Colors.transparent,
                      title: const Text(
                        'Acessar o app',
                        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}