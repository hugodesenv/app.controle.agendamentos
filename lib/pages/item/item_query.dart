import 'package:agendamentos/assets/utilsConstantes.dart';
import 'package:agendamentos/pages/item/bloc/item_query_bloc.dart';
import 'package:agendamentos/pages/item/bloc/item_query_event.dart';
import 'package:agendamentos/pages/item/bloc/item_query_state.dart';
import 'package:agendamentos/pages/item/product/new/product_new.dart';
import 'package:agendamentos/pages/item/product/query/product_query.dart';
import 'package:agendamentos/pages/item/service/query/service_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemQuery extends StatelessWidget {
  const ItemQuery({Key? key}) : super(key: key);

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'O que deseja cadastrar?',
                    textAlign: TextAlign.center,
                    style: textStyleTitleModalBottomSheet(context),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.handyman_outlined),
                  title: const Text('Produto'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _showProductNew(context);
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
    return BlocBuilder(
      bloc: BlocProvider.of<ItemQueryBloc>(context),
      builder: (_, state) {
        var bloc = BlocProvider.of<ItemQueryBloc>(context);
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
                  ProductQuery(),
                  ServiceQuery(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
