import 'package:agendamentos/pages/client_search/bloc/client_search_bloc.dart';
import 'package:agendamentos/pages/client_search/bloc/client_search_event.dart';
import 'package:agendamentos/pages/client_search/bloc/client_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientSearch extends StatelessWidget {
  const ClientSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliente'),
        actions: [
          IconButton(
            onPressed: () =>
                BlocProvider.of<ClientSearchBloc>(context).add(ClientSearchEventTapNew()),
            icon: const Icon(Icons.person_add_alt),
          ),
        ],
      ),
      body: BlocListener(
        bloc: BlocProvider.of<ClientSearchBloc>(context),
        listener: (context, state) async {
          if (state is ClientSearchStateShowOptionsNew) {
            return await showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      ListTile(
                        title: const Text("Cadastrar manualmente"),
                        leading: const Icon(Icons.person_add_alt_1_outlined),
                        onTap: () {
                          print("Chamar a tela do cadastro do usuario");
                        },
                      ),
                      ListTile(
                        title: const Text("Importar dos contatos"),
                        leading: const Icon(Icons.contact_mail_outlined),
                        onTap: () {
                          print("Chamar a tela para importar os dados");
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<ClientSearchBloc>(context),
          builder: (context, state) {
            return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ListTile(
                  title: const Text("Hugo Souza", style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: const Text("(19) 9 8961-5184"),
                  onTap: () {},
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 25,
            );
          },
        ),
      ),
    );
  }
}
