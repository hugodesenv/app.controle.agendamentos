import 'package:flutter/material.dart';

class Relatorio extends StatelessWidget {
  const Relatorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório'),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              descricao(
                  'Tela de adicionar novos produtos: Precisamos arrumar várias coisas aqui... Do tipo: A criação da instancia do provider deve ser feita ao abrir a tela, porque senao vai ficar guardado coisas em memorias e pode dar ruim.' +
                      'Também é preciso que seja criado os outros componentes (ativo etc.)',
                  Colors.blue),
              descricao(
                  'Desenvolver o mecanismo para adicionar o serviço. Também criar esquema de alteração de dados ao clicar sob o item',
                  Colors.blueAccent),
              const Divider(),
              descricao(
                  'Na tela home: É necessário por um botão do tipo floatting button que ao clicar sob ele, apareça mais opções inves de deixar o botao na appbar',
                  Colors.orange),
              const Divider(),
              descricao(
                  'Também é necessário instanciar o provider do "novo agendamento" ao clicar sob ele, porque está guardando lixo em memoria mesmo fechando a tela',
                  Colors.orange),
              const Divider(),
              descricao('No cadastro do cliente, remover o BloC', Colors.pink),
              descricao(
                  'Desenvolver a tela de informações + ultimos agendamentos',
                  Colors.pink),
              const Divider(),
              descricao('Desenvolver tela de configuraçoes', Colors.green),
              const Divider(),
              descricao(
                  'Na tela de login, deve corrigir a questao de: Verificar se o usuario ja esta logado e direciona-lo para a tela home ou pra tela login',
                  Colors.brown),
              descricao('Criar tela de splash do app', Colors.brown),
            ],
          ),
        ),
      ),
    );
  }

  Widget descricao(descricao, cor) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        descricao,
        style: TextStyle(
          color: cor,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
