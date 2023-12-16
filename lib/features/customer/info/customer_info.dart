import 'package:agendamentos/enum/formulario_estado_enum.dart';
import 'package:agendamentos/features/customer/info/bloc/customer_info_bloc.dart';
import 'package:agendamentos/features/customer/info/bloc/customer_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/widgetsConstantes.dart';
import 'bloc/customer_info_event.dart';

class CustomerInfo extends StatelessWidget {
  CustomerInfo({Key? key}) : super(key: key);

  Future onTapEdit({required BuildContext context}) async {
    var customer = context.read<CustomerInfoBloc>().state.customer;
    await Future.delayed(
      Duration.zero,
      () async {
        await Navigator.pushNamed(context, RoutesConstants.routeCustomerNew,
            arguments: customer);
        Navigator.pop(context);
      },
    );
  }

  List<PopupMenuEntry<dynamic>> menuWidgets(
    BuildContext context,
    CustomerInfoBloc infoBloc,
  ) {
    return [
      PopupMenuItem(
        child: const Text('Alterar'),
        onTap: () async {
          await onTapEdit(context: context);
        },
      ),
      PopupMenuItem(
        child: const Text(
          'Remover',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red),
        ),
        onTap: () async {
          await Future.delayed(
            Duration.zero,
            () async {
              await Dialogs.materialDialog(
                context: context,
                title: 'Confirmação',
                msg: 'Deseja excluir o cliente?',
                actions: [
                  IconsButton(
                    onPressed: () {
                      Navigator.pop(context); // to close the dialog
                      BlocProvider.of<CustomerInfoBloc>(context)
                          .add(CustomerInfoEventDelete());
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
    await Navigator.pushNamed(context, RoutesConstants.routeSchedule);
  }

  @override
  Widget build(BuildContext context) {
    var infoBloc = BlocProvider.of<CustomerInfoBloc>(context);

    return BlocListener(
      bloc: infoBloc,
      listener: (context, state) {
        if (state is CustomerInfoState) {
          if (state.status == FormularioEstado.FALHA) {
            mySnackbar(context, state.message!, background: Colors.red);
          } else if (state.status == FormularioEstado.EXCLUIDO) {
            mySnackbar(context, state.message!);
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder(
        bloc: infoBloc,
        builder: (context, CustomerInfoState state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Info.'),
              actions: [
                IconButton(
                  onPressed: () async => await _onTapSchedule(context),
                  icon: const Icon(Icons.pending_actions),
                ),
                PopupMenuButton(
                    itemBuilder: (_) => menuWidgets(context, infoBloc)),
              ],
            ),
            body: BlocBuilder(
              bloc: infoBloc,
              builder: (_, CustomerInfoState state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 10, left: 20, right: 20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _nameInput(),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: _cellphoneInput(),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Últimos agendamentos",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Flexible(
                      child: ListView.separated(
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return const ListTile(
                            title: Text('Concluído'),
                            subtitle: Text('10/01/23 às 10h35'),
                            trailing:
                                Icon(Icons.arrow_forward_ios_rounded, size: 10),
                          );
                        },
                        separatorBuilder: (_, int index) => const Divider(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () => infoBloc.add(
                            CustomerInfoEventOpenWhatsApp(
                                state.customer.cellphone)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              ColorConstants.whatsappColor,
                            ),
                            padding: const EdgeInsets.all(10)),
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
          );
        },
      ),
    );
  }
}

// ignore: camel_case_types
class _nameInput extends StatelessWidget {
  const _nameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
      buildWhen: (previous, current) =>
          previous.customer.name != current.customer.name,
      builder: (context, CustomerInfoState state) {
        return Text(
          state.customer.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        );
      },
    );
  }
}

// ignore: camel_case_types
class _cellphoneInput extends StatelessWidget {
  const _cellphoneInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerInfoBloc, CustomerInfoState>(
      buildWhen: (previous, current) =>
          previous.customer.cellphone != current.customer.cellphone,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone, size: 18),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                state.customer.cellphone,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
