import 'package:agendamentos/features/item/produto/consulta/produto_consulta_page.dart';
import 'package:agendamentos/features/item/produto/consulta/produto_consulta_provider.dart';
import 'package:agendamentos/features/item/produto/new/product_new.dart';
import 'package:agendamentos/features/item/service/query/service_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants/widgetsConstantes.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  void initState() {
    super.initState();
  }

  Future _showProductNew(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return const ProductNew();
      },
    );
  }

  Future _showOptionInput(BuildContext context) async {
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
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'O que deseja cadastrar?',
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.handyman_outlined),
                  title: Text('Produto'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _showProductNew(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.home_repair_service),
                  title: Text('Serviço'),
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
          title: const Text('Meus itens'),
          bottom: const TabBar(
            tabs: [
              Icon(Icons.handyman_outlined),
              Icon(Icons.home_repair_service),
            ],
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  onTap: () async => await _showOptionInput(context),
                  child: const Text('Novo'),
                ),
              ],
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              ProdutoConsultaPage(),
              ServiceQuery(),
            ],
          ),
        ),
      ),
    );
  }
}
