import 'package:agendamentos/features/item/item_provider.dart';
import 'package:agendamentos/features/item/produto/produto_consulta_page.dart';
import 'package:agendamentos/features/item/servico/servico_consulta_page.dart';
import 'package:agendamentos/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/widgetsConstantes.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late final ItemProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<ItemProvider>();
    WidgetsBinding.instance.addPostFrameCallback(callbackPostFrame);
  }

  callbackPostFrame(Duration pDuration) async {
    await provider.buscarItens();
  }

  Future _abrirOpcoesInclusao(BuildContext context) async {
    await Future.delayed(
      Duration.zero,
      () async => await showModalBottomSheet(
        context: context,
        shape: shapeModalBottomSheet,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'O que deseja cadastrar?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.handyman_outlined),
                  title: const Text('Produto'),
                  onTap: () async {
                    Navigator.pop(context);
                    await Navigator.pushNamed(
                        context, RoutesConstants.routeProdutoNovo);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.home_repair_service),
                  title: const Text('Serviço'),
                  onTap: () {
                    Navigator.pop(context);
                    // call services screen here
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<ItemProvider>(
            builder: (_, value, __) => Text(value.tituloAppBar),
          ),
          actions: [
            IconButton(
              onPressed: () async => await provider.buscarItens(),
              icon: const Icon(Icons.refresh_outlined),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Icon(Icons.handyman_outlined),
              Icon(Icons.home_repair_service),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    ProdutoConsultaPage(),
                    ServicoConsultaPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await _abrirOpcoesInclusao(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
