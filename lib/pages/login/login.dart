import 'package:agendamentos/pages/login/bloc/login_bloc.dart';
import 'package:agendamentos/pages/login/bloc/login_event.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/text_field/my_login_text_field.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _doForgetPassword() async {
    print("** nada por aqui **");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: BlocProvider.of<LoginBloc>(context),
        listener: (BuildContext context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, ROUTE_HOME);
            return;
          }

          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            return;
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<LoginBloc>(context),
          builder: (BuildContext context, state) {
            bool loading = state is LoginLoading;
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
                            labelText: 'Usuário', controller: userController, autoFocus: true),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: MyLoginTextField(
                            labelText: 'Senha',
                            controller: passwordController,
                            isPassword: true,
                          ),
                        ),
                        TextButton(
                          onPressed: () async => await _doForgetPassword,
                          style: const ButtonStyle(alignment: Alignment.centerRight),
                          child: const Text('Esqueceu a senha?'),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginSubmitted(
                              username: userController.text, password: passwordController.text),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: loading
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(color: Colors.orange),
                            )
                          : const Text('Entrar'),
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
