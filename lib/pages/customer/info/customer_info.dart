import 'package:agendamentos/model/arguments/args_customer_info.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/pages/customer/info/bloc/customer_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import '../../../assets/colorConstantes.dart';
import '../../../assets/utilsConstantes.dart';
import '../../../assets/routesConstants.dart';
import '../../../model/arguments/args_customer_new.dart';
import '../../../model/customer.dart';
import '../../schedule/schedule.dart';
import 'bloc/customer_info_event.dart';

class CustomerInfo extends StatelessWidget {
  final ArgsCustomerInfo argument;

  const CustomerInfo({Key? key, required this.argument}) : super(key: key);

  void onTapWhatsApp(BuildContext context, String cellphone) {
    BlocProvider.of<CustomerInfoBloc>(context).add(CustomerInfoEventOpenWhatsApp(cellphone));
  }

  Future onTapEdit({required BuildContext context, required CustomerInfoBloc infoBloc, required Customer customer}) async {
    await Future.delayed(
      zeroDuration,
      () async {
        var args = ArgsCustomerNew.info(infoBloc: infoBloc, customer: customer);
        await Navigator.pushNamed(context, routeCustomerNew, arguments: args);
      },
    );
  }

  List<PopupMenuEntry<dynamic>> menuWidgets(
    BuildContext context,
    CustomerInfoBloc infoBloc,
    Customer customer,
  ) {
    return [
      PopupMenuItem(
        child: const Text('Alterar'),
        onTap: () async => await onTapEdit(
          context: context,
          customer: customer,
          infoBloc: infoBloc,
        ),
      ),
      PopupMenuItem(
        child: const Text(
          'Excluir',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
        ),
        onTap: () async {
          await Future.delayed(
            zeroDuration,
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

  Future _onTapSchedule(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      builder: (_) {
        return Schedule();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Customer customer = Customer.empty();
    var nameController = TextEditingController();
    var cellphoneController = TextEditingController();
    var infoBloc = BlocProvider.of<CustomerInfoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Info.'),
        actions: [
          IconButton(
            onPressed: () async => await _onTapSchedule(context),
            icon: const Icon(Icons.pending_actions),
          ),
          PopupMenuButton(itemBuilder: (_) => menuWidgets(context, infoBloc, customer)),
        ],
      ),
      body: BlocListener(
        bloc: infoBloc,
        listener: (_, state) {
          if (state is CustomerInfoStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is CustomerInfoStateDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          }
        },
        child: BlocBuilder(
          bloc: infoBloc,
          builder: (_, state) {
            bool isWhatsAppLoading = state is CustomerInfoStateLoading && state.isBusy;

            if (state is CustomerInfoStateRefresh) {
              customer = state.customer;
              nameController.text = customer.name;
              cellphoneController.text = customer.cellphone;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        nameController.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone, size: 18),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(cellphoneController.text, style: const TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Últimos agendamentos",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return const ListTile(
                        title: Text('Concluído'),
                        subtitle: Text('10/01/23 às 10h35'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 10),
                      );
                    },
                    separatorBuilder: (_, int index) => const Divider(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isWhatsAppLoading
                      ? const Text(
                          "Carregando...",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(whatsappColor), fontWeight: FontWeight.w700),
                        )
                      : ElevatedButton(
                          onPressed: () => onTapWhatsApp(context, customer.cellphone),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(whatsappColor), padding: const EdgeInsets.all(10)),
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
            );
          },
        ),
      ),
    );
  }
}
