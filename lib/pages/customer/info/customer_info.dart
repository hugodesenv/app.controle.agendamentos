import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/constants.dart';

class CustomerInfo extends StatelessWidget {
  final void Function() onDelete;

  const CustomerInfo({Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainColor = Theme.of(context).primaryColor;
    var bloc = BlocProvider.of<CustomerInfoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info.'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Alterar')),
              PopupMenuItem(
                child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                onTap: () => bloc.add(CustomerInfoEventDelete()),
              ),
            ],
          ),
        ],
      ),
      body: BlocListener(
        bloc: bloc,
        listener: (_, state) {
          if (state is CustomerInfoStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            return;
          }

          if (state is CustomerInfoStateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            state.typeSuccess == TypeSuccess.tpDelete ? onDelete() : null;
            Navigator.pop(context);
            return;
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            bool isWhatsAppLoading = state is CustomerInfoStateLoading && state.isBusy;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        bloc.customer!.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: mainColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone),
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(bloc.customer!.cellphone),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: isWhatsAppLoading
                            ? const Text(
                                "Carregando...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(COLOR_WHATSAPP), fontWeight: FontWeight.w700),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<CustomerInfoBloc>(context)
                                      .add(CustomerInfoEventOpenWhatsApp(bloc.customer!.cellphone));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(COLOR_WHATSAPP)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.phone_iphone),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("Chamar no WhatsApp"),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Últimos agendamentos",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return const ListTile(
                        title: Text('Concluído'),
                        subtitle: Text('10/01/23 às 10h35'),
                      );
                    },
                    separatorBuilder: (_, int index) => const Divider(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.schedule),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Criar compromisso'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
