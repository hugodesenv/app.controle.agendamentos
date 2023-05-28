import 'package:agendamentos/model/arguments/args_customer_info.dart';
import 'package:agendamentos/model/arguments/args_customer_new.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/routes.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../../assets/constants.dart';
import '../../../model/customer.dart';

class CustomerInfo extends StatelessWidget {
  final ArgsCustomerInfo argument;

  const CustomerInfo({Key? key, required this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var cellphoneController = TextEditingController();
    Customer customer = Customer.empty();

    var bloc = BlocProvider.of<CustomerInfoBloc>(context);

    handleValues() {
      nameController.text = customer.name;
      cellphoneController.text = customer.cellphone;
    }

    onTapWhatsApp() {
      BlocProvider.of<CustomerInfoBloc>(context).add(
        CustomerInfoEventOpenWhatsApp(customer.cellphone),
      );
    }

    Future onTapEdit() async {
      await Future.delayed(
        Duration.zero,
        () async {
          var args = ArgsCustomerNew.info(infoBloc: bloc, customer: customer);
          await Navigator.pushNamed(context, routeCustomerNew, arguments: args);
        },
      );
    }

    List<PopupMenuEntry<dynamic>> menuWidgets() {
      return [
        PopupMenuItem(
          child: const Text('Alterar'),
          onTap: () async => await onTapEdit(),
        ),
        PopupMenuItem(
          child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          onTap: () async {
            await Future.delayed(
              const Duration(seconds: 0),
              () async {
                await Dialogs.materialDialog(
                  context: context,
                  title: 'Confirmação',
                  msg: 'Deseja excluir o cliente?',
                  actions: [
                    IconsButton(
                      onPressed: () {
                        Navigator.pop(context);
                        BlocProvider.of<CustomerInfoBloc>(context).add(CustomerInfoEventDelete());
                      },
                      text: 'Sim',
                      iconData: Icons.delete,
                      color: Colors.red,
                      textStyle: const TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                    ),
                    IconsOutlineButton(
                      onPressed: () => Navigator.pop(context),
                      text: 'Não',
                      iconData: Icons.cancel_outlined,
                      textStyle: const TextStyle(color: Colors.grey),
                      iconColor: Colors.grey,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Info.'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => menuWidgets(),
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
          if (state is CustomerInfoStateDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
            return;
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (_, state) {
            bool isWhatsAppLoading = state is CustomerInfoStateLoading && state.isBusy;
            if (state is CustomerInfoStateRefresh) {
              customer = state.customer;
              handleValues();
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
                        nameController.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone),
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(cellphoneController.text),
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
                                style: TextStyle(color: Color(COLOR_WHATSAPP), fontWeight: FontWeight.w700),
                              )
                            : ElevatedButton(
                                onPressed: () => onTapWhatsApp(),
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Flexible(
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
