import 'package:agendamentos/features/acesso/provider/login_provider.dart';
import 'package:agendamentos/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/widgetsConstantes.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late LoginProvider loginProvider;
  late TextEditingController userController;
  late TextEditingController passwordController;
  late TextEditingController emailResetController;

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

  // clique do botão "entrar", na qual faz a tentativa de login no aplicativo
  Future<void> tentarFazerLogin(BuildContext context) async {
    String res = await loginProvider.tryLogin(
        userController.text, passwordController.text);

    if (res.isNotEmpty) {
      // ignore: use_build_context_synchronously
      await showStateDialog(context, res, isError: true);
      return;
    }

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(RoutesConstants.routeHome);
  }

  Future<void> showStateDialog(
    BuildContext context,
    String message, {
    bool? isError,
  }) async {
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

  Future<void> tryResetAccess() async {
    Map res = await loginProvider.sendResetUserEmail(emailResetController.text);
    // ignore: use_build_context_synchronously
    await showStateDialog(
      context,
      res['message'],
      isError: res['error'],
    );
  }

  Future<Widget> showModalResetPassword() async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: shapeModalBottomSheet,
      builder: (_) {
        return Consumer<LoginProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 20,
                top: 20,
                right: 20,
              ),
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
                    title: const Text('Enviar'),
                    loading: loginProvider.resetPassword,
                    onPressed: () async {
                      await tryResetAccess();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    userController = TextEditingController();
    passwordController = TextEditingController();
    emailResetController = TextEditingController();

    Future abrirModalAreaAcesso() async {
      await showModalBottomSheet(
        context: context,
        shape: shapeModalBottomSheet,
        isScrollControlled: true,
        builder: (_) {
          return Consumer<LoginProvider>(
            builder: (context, value, child) {
              return Container(
                padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 30,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      loading: loginProvider.loading,
                      onPressed: () async => await tentarFazerLogin(context),
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
                        onPressed: () async => await showModalResetPassword(),
                        child: const Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(color: Colors.black26),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              const Color.fromARGB(255, 104, 185, 252),
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
                onPressed: () async => await abrirModalAreaAcesso(),
                colorBackground: Colors.transparent,
                title: const Text(
                  'Acessar o app',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
          ],
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_thickness ?? 20.0)),
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
    IconData icon = widget._hideText
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    return GestureDetector(
      child:
          Icon(icon, color: widget._hideText ? pMainColor : Colors.pinkAccent),
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
        labelStyle: TextStyle(
            color: mainColor, fontWeight: FontWeight.w500, fontSize: 15),
        labelText: widget._labelText,
        suffixIcon: widget._isPassword == true ? _suffixIcon(mainColor) : null,
        suffixIconColor: mainColor,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.5),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).focusColor, width: 3),
            borderRadius: BorderRadius.circular(20)),
      ),
      cursorColor: mainColor,
      style: TextStyle(color: mainColor),
    );
  }
}
