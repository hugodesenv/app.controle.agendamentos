import 'package:agendamentos/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_event.dart';
import 'package:agendamentos/pages/sign_in/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/dialogs.dart';

import '../../utils/constants/routesConstants.dart';
import '../../utils/constants/widgetsConstantes.dart';

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
    await Dialogs.materialDialog(
      context: context,
      title: message,
      titleStyle: TextStyle(
        color: isError == false ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SignInBloc>(context);
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailResetController = TextEditingController();

    Future showSignIn() async {
      await showModalBottomSheet(
        context: context,
        shape: shapeModalBottomSheet,
        isScrollControlled: true,
        builder: (_) {
          return BlocListener(
            bloc: bloc,
            listener: (_, state) async {
              if (state is SignInStateSuccess) {
                Navigator.pushReplacementNamed(context, routeHome);
              } else if (state is SignInStateFailure) {
                await _simpleDialog(context, state.message);
              } else if (state is SignInStateResetPassword) {
                await _simpleDialog(context, state.message, isError: state.emailSent == false);
              }
            },
            child: BlocBuilder(
              bloc: bloc,
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
                          labelText: 'Usuário',
                          controller: userController,
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
                          bloc.add(SignInEventSubmitted(username: userController.text, password: passwordController.text));
                        },
                        title: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(alignment: Alignment.topCenter),
                        child: TextButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: shapeModalBottomSheet,
                              builder: (_) {
                                return BlocBuilder(
                                  bloc: bloc,
                                  builder: (_, state) {
                                    bool isLoadingReset = state is SignInStateWaitingEmailReset;
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 20, top: 20, right: 20),
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
                                            onPressed: () => bloc.add(
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
      resizeToAvoidBottomInset: false,
      body: BlocListener(
        bloc: bloc,
        listener: (_, state) async {
          if (state is SignInStateGoToHome) {
            await Navigator.pushReplacementNamed(context, routeHome);
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (_, state) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5ee0ad),
                    Colors.teal,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Skedol',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
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

///// internal class
// ignore: must_be_immutable
class MyLoadingButton extends StatelessWidget {
  VoidCallback _onPressed = () {};
  Widget? _title;
  double? _thickness;
  bool? _loading;
  double _sizeProgress = 0;
  Color? _colorBackground;

  MyLoadingButton({
    Key? key,
    required VoidCallback onPressed,
    required Widget title,
    double? thickness,
    bool? loading,
    double? sizeProgress,
    Color? colorBackground,
  }) : super(key: key) {
    _onPressed = onPressed;
    _colorBackground = colorBackground;
    _title = title;
    _thickness = thickness;
    _loading = loading;
    _sizeProgress = sizeProgress ?? 15;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onPressed(),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_thickness ?? 20.0)),
        backgroundColor: _colorBackground ?? Theme.of(context).primaryColor,
      ),
      child: _loading == true
          ? SizedBox(
              height: _sizeProgress,
              width: _sizeProgress,
              child: const CircularProgressIndicator(),
            )
          : _title,
    );
  }
}

// ignore: must_be_immutable
///// internal class...
class MyLoginTextField extends StatefulWidget {
  String _labelText = '';
  TextEditingController? _controller;
  bool _hideText = true;
  bool? _isPassword;
  bool _autoFocus = false;
  TextInputType? _keyboardType;

  MyLoginTextField({
    super.key,
    TextEditingController? controller,
    required labelText,
    bool? isPassword,
    bool? autoFocus,
    TextInputType? keyboardType,
  }) {
    _labelText = labelText;
    _controller = controller;
    _isPassword = isPassword ?? false;
    _autoFocus = autoFocus ?? false;
    _keyboardType = keyboardType;
  }

  @override
  State<MyLoginTextField> createState() => _MyLoginTextFieldState();
}

class _MyLoginTextFieldState extends State<MyLoginTextField> {
  Widget _suffixIcon(Color pMainColor) {
    IconData icon = widget._hideText ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    return GestureDetector(
      child: Icon(icon, color: widget._hideText ? pMainColor : Colors.pinkAccent),
      onTap: () async {
        setState(() {
          widget._hideText = !widget._hideText;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Theme.of(context).primaryColor;

    return TextField(
      autofocus: widget._autoFocus,
      controller: widget._controller,
      obscureText: widget._hideText && widget._isPassword == true,
      keyboardType: widget._keyboardType,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w500, fontSize: 15),
        labelText: widget._labelText,
        suffixIcon: widget._isPassword == true ? _suffixIcon(mainColor) : null,
        suffixIconColor: mainColor,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: mainColor, width: 1.5), borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor, width: 3), borderRadius: BorderRadius.circular(20)),
      ),
      cursorColor: mainColor,
      style: TextStyle(color: mainColor),
    );
  }
}
