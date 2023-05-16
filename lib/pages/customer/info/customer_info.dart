import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../assets/constants.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({Key? key, required this.customer}) : super(key: key);
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    var mainColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info.'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Alterar')),
              const PopupMenuItem(child: Text('Excluir', style: TextStyle(color: Colors.red))),
            ],
          ),
        ],
      ),
      body: BlocListener(
        bloc: BlocProvider.of<CustomerInfoBloc>(context),
        listener: (_, state) {
          if (state is CustomerInfoStateWhatsAppFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<CustomerInfoBloc>(context),
          builder: (context, state) {
            bool isWhatsLoading = false;
            if (state is CustomerInfoStateLoadingWhatsApp) {
              isWhatsLoading = state.isLoading;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        customer.name,
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
                              child: Text(customer.cellphone),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: isWhatsLoading
                            ? const Text(
                                "Carregando...",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(COLOR_WHATSAPP), fontWeight: FontWeight.w700),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<CustomerInfoBloc>(context)
                                      .add(CustomerInfoEventOpenWhatsApp(customer.cellphone));
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(COLOR_WHATSAPP)),
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
                    onPressed: () {},
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
