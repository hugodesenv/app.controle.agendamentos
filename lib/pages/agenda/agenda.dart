import 'package:agendamentos/mixin/validacao_formulario/agenda_validacao_mixin.dart';
import 'package:agendamentos/pages/agenda/widget/agenda_situacao.dart';
import 'package:agendamentos/provider/agenda_item_provider.dart';
import 'package:agendamentos/provider/agenda_provider.dart';
import 'package:agendamentos/widgets/my_date_field.dart';
import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/schedule_item.dart';
import '../../utils/constants/widgetsConstantes.dart';
import '../../utils/datetime_util.dart';
import '../../utils/dialogs_util.dart';
import '../../widgets/my_modal_search/enum/my_modal_search_enum.dart';
import '../../widgets/my_numeric_field.dart';
import '../../widgets/my_text_title.dart';

class Parametros {
  DateTime? scheduleDate;
  Parametros({required this.scheduleDate});
}

class Agenda extends StatefulWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> with AgendaValidacaoMixin {
  final _formKey = GlobalKey<FormState>();

  AppBar appBar() {
    return AppBar(title: const Text('Compromisso'));
  }

  body(BuildContext context) {
    var provider = context.read<AgendaProvider>();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 8.0,
          top: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyModalSearch(
              typeSearch: MyModalSearchEnum.tEmployee,
              initialValue: provider.agenda.employee.nome,
              validator: (mensagem) => combine([
                () => clienteVazio(mensagem ?? ''),
              ]),
              onTap: (model) => provider.alterarProfissional(model),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: MyModalSearch(
                typeSearch: MyModalSearchEnum.tCustomer,
                validator: (mensagem) => combine([
                  () => profissionalVazio(mensagem ?? ''),
                ]),
                initialValue: provider.agenda.customer.name,
                onTap: (model) => provider.alterarCliente(model),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: MyDateField(
                title: 'Data / Hora',
                initialValue: provider.agenda.scheduleDate,
                onChanged: (DateTime? selectedDate) =>
                    provider.alterarDataHora(selectedDate),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: ScheduleItems(),
            ),
            AgendaSituacao(
              onResult: ({situation, text}) {
                provider.alterarSituacao(situation);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _formSave(BuildContext context) async {
    if (_formKey.currentState!.validate() == false) {
      return;
    }

    await context.read<AgendaProvider>().salvar();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: appBar(),
          body: body(context),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save_outlined),
            onPressed: () => _formSave(context),
          ),
        );
      },
    );
  }
}

class ScheduleItems extends StatefulWidget {
  const ScheduleItems({Key? key}) : super(key: key);

  @override
  State<ScheduleItems> createState() => ScheduleItemsState();
}

class ScheduleItemsState extends State<ScheduleItems> {
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

class ScheduleModalAddItems extends StatefulWidget {
  ScheduleItem? scheduleItem;
  Function(ScheduleItem currentItem) onResultItem;

  ScheduleModalAddItems({
    super.key,
    this.scheduleItem,
    required this.onResultItem,
  });

  @override
  State<ScheduleModalAddItems> createState() => _ScheduleModalAddItemsState();
}

class _ScheduleModalAddItemsState extends State<ScheduleModalAddItems> {
  @override
  void initState() {
    context.read<AgendaItemProvider>().scheduleItem = widget.scheduleItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AgendaItemProvider>(
      builder: (context, provider, _) {
        var title =
            provider.scheduleItem.item.id.isEmpty ? 'Adicionar' : 'Alterar';
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyTextTitle(
                  title: title,
                  align: TextAlign.center,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: MyModalSearch(
                    initialValue: provider.scheduleItem.item.description,
                    typeSearch: MyModalSearchEnum.tItem,
                    onTap: (model) => provider.changeItem(model),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: MyNumericField(
                          title: 'Valor',
                          decimalSize: 2,
                          initialValue: provider.scheduleItem.price.toString(),
                          iconData: Icons.attach_money_rounded,
                          onChange: (value) => provider.changeItemPrice(value),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: MyNumericField(
                          title: 'Tempo',
                          iconData: Icons.access_time_sharp,
                          initialValue:
                              provider.scheduleItem.serviceMinutes.toString(),
                          onChange: (value) =>
                              provider.changeItemTimeService(value),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      widget.onResultItem(provider.scheduleItem);
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.save_outlined),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
