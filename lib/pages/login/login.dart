import 'package:agendamentos/pages/login/bloc/login_bloc.dart';
import 'package:agendamentos/pages/login/bloc/login_event.dart';
import 'package:agendamentos/pages/login/bloc/login_state.dart';
import 'package:agendamentos/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _usuario = TextEditingController();
    TextEditingController _senha = TextEditingController();

    return Scaffold(
      body: BlocListener(
        bloc: BlocProvider.of<LoginBloc>(context),
        listener: (BuildContext context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, ROUTE_HOME);
          } else if (state is LoginFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<LoginBloc>(context),
          builder: (BuildContext context, state) {
            bool loading = state is LoginLoading;
            return Opacity(
              opacity: loading ? 0.5 : 1,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Agenda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            decoration: const InputDecoration(labelText: 'Usuário'),
                            autofocus: true,
                            controller: _usuario,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              suffixIcon: Icon(Icons.visibility_outlined),
                            ),
                            obscureText: true,
                            controller: _senha,
                          ),
                          TextButton(
                            onPressed: () {},
                            style: const ButtonStyle(alignment: Alignment.centerRight),
                            child: const Text('Esqueceu a senha?'),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        child: loading
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Acessar'),
                        onPressed: () async {
                          BlocProvider.of<LoginBloc>(context).add(LoginSubmitted());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
