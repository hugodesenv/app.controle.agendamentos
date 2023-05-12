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

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future showSignIn() async {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return BlocListener(
            bloc: BlocProvider.of<SignInBloc>(context),
            listener: (_, state) async {
              if (state is SignInStateSuccess) {
                Navigator.pushReplacementNamed(context, ROUTE_HOME);
              }

              if (state is SignInStateFailure) {
                await AwesomeDialog(
                  autoHide: const Duration(seconds: 3),
                  context: context,
                  dialogType: DialogType.noHeader,
                  padding: const EdgeInsets.all(15),
                  title: state.message,
                  titleTextStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ).show();
              }
            },
            child: BlocBuilder(
              bloc: BlocProvider.of<SignInBloc>(context),
              builder: (_, state) {
                bool isLoading = state is SignInStateLoading;
                double viewBottom = MediaQuery.of(context).viewInsets.bottom;

                return Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: viewBottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Área de acesso',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MyLoginTextField(
                          labelText: 'E-mail',
                          controller: emailController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MyLoginTextField(
                          labelText: 'Senha',
                          controller: passwordController,
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
                        child: const Text('Esqueceu sua senha?', style: TextStyle(color: Colors.black26)),
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
              color: Colors.indigo,
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
                      colorBackground: Colors.black45,
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
