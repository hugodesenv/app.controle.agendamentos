import 'package:agendamentos/features/agenda/agenda_page.dart';
import 'package:agendamentos/features/agenda/provider/agenda_provider.dart';
import 'package:agendamentos/utils/datetime_util.dart';
import 'package:agendamentos/utils/dialogs_util.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/schedule_item.dart';
import '../provider/agenda_item_provider.dart';
import '../../../utils/constants/widgetsConstantes.dart';
import '../../../widgets/my_text_title.dart';

class AgendaItem extends StatefulWidget {
  const AgendaItem({Key? key}) : super(key: key);

  @override
  State<AgendaItem> createState() => AgendaItemState();
}

class AgendaItemState extends State<AgendaItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AgendaProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            campoTituloDoItem(),
            ...listagemDeItens(context),
            const Divider(),
            campoTotal(context),
            const Divider(),
          ],
        );
      },
    );
  }

  Iterable<ListTile> listagemDeItens(BuildContext context) {
    var model = context.read<AgendaProvider>().agenda.scheduleItem;
    return model.map(
      (item) {
        double leftPadding = 20.0;
        return ListTile(
          title: Padding(
            padding: EdgeInsets.only(left: leftPadding),
            child: Text(
              item.item.description,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(left: leftPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(UtilBrasilFields.obterReal(item.price)),
                Text(
                  "${DateTimeUtil.formatTimeHHMM(Duration(minutes: item.serviceMinutes))}h",
                ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.zero,
          onTap: () async =>
              await abrirDetalhamentoDoItem(context, scheduleItem: item),
          trailing: IconButton(
            onPressed: () async {
              await DialogsUtil.confirmation(
                context,
                'Deseja mesmo remover o item?',
                item.item.description,
                () => context.read<AgendaProvider>().removerItem(item),
              );

              print("** dps");
            },
            icon: const Icon(
              Icons.delete_outlined,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget campoTituloDoItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTextTitle(title: 'Adicionar itens'),
        IconButton(
          icon: const Icon(Icons.post_add_sharp),
          onPressed: () async {
            await abrirDetalhamentoDoItem(context);
          },
        ),
      ],
    );
  }

  Widget campoTotal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Text(
        context.read<AgendaProvider>().agenda.getTotalDescription(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Future<void> abrirDetalhamentoDoItem(
    BuildContext context, {
    ScheduleItem? scheduleItem,
  }) async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      isScrollControlled: true,
      builder: (_) {
        return ChangeNotifierProvider(
          create: (_) => AgendaItemProvider(),
          builder: (context, _) => ScheduleModalAddItems(
            scheduleItem: scheduleItem,
            onResultItem: (currentItem) {
              context.read<AgendaProvider>().adicionarItem(currentItem);
            },
          ),
        );
      },
    );
  }
}
