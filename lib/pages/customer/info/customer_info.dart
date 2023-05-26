import 'package:agendamentos/model/customer.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_event.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_bloc.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_event.dart';
import 'package:agendamentos/pages/customer/new/bloc/customer_new_state.dart';
import 'package:agendamentos/pages/customer/new/customer_new.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_bloc.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_event.dart';
import 'package:agendamentos/pages/customer/query/bloc/customer_query_state.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import '../../../assets/constants.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<CustomerInfoBloc>(context);
    var blocQuery = bloc.customerQueryBloc;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Info.'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => _menuWidgets(context),
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
            blocQuery.add(CustomerQueryEventRemoveFromList(state.customer));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
            return;
          }
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (_, state) {
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
                        bloc.customer.name,
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
                              child: Text(UtilBrasilFields.obterTelefone(bloc.customer.cellphone)),
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
                                onPressed: () => _onTapWhatsApp(context, bloc.customer.cellphone),
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

  Future onTapEdit(BuildContext buildContext, Customer customer) async {
    Future.delayed(
      const Duration(seconds: 0),
      () async {
        Navigator.push(
          buildContext,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => CustomerNewBloc(CustomerNewStateInitial(), arguments: null /** arrumar */)..add(CustomerNewEventEditMode(customer)),
              child: const CustomerNew(), //@@arrumar
            ),
          ),
        );
      },
    );
  }

  List<PopupMenuEntry<dynamic>> _menuWidgets(buildContext) {
    return [
      PopupMenuItem(
        child: const Text('Alterar'),
        onTap: () {},
      ),
      PopupMenuItem(
        child: const Text('Excluir', style: TextStyle(color: Colors.red)),
        onTap: () async {
          Future.delayed(
            const Duration(seconds: 0),
            () => Dialogs.materialDialog(
              context: buildContext,
              title: 'Confirmação',
              msg: 'Deseja excluir o cliente?',
              actions: [
                IconsButton(
                  onPressed: () {
                    BlocProvider.of<CustomerInfoBloc>(buildContext).add(CustomerInfoEventDelete());
                  },
                  text: 'Sim',
                  iconData: Icons.delete,
                  color: Colors.red,
                  textStyle: const TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
                IconsOutlineButton(
                  onPressed: () => Navigator.pop(buildContext),
                  text: 'Não',
                  iconData: Icons.cancel_outlined,
                  textStyle: const TextStyle(color: Colors.grey),
                  iconColor: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    ];
  }

  _onTapWhatsApp(BuildContext buildContext, String cellphone) {
    BlocProvider.of<CustomerInfoBloc>(buildContext).add(
      CustomerInfoEventOpenWhatsApp(cellphone),
    );
  }
}
