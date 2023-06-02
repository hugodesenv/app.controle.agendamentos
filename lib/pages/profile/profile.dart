import 'package:agendamentos/repository/user_repository.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("*** login do tipo singleton aqui no profile.dart");
    print(UserRepository.instance.currentLogin.name);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Text('Puxar os dados do usuário aqui... E depois que atualizado, retornar pra primeira tela!'),
          ],
        ),
      ),
    );
  }
}
