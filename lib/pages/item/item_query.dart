import 'package:agendamentos/assets/utilsConstantes.dart';
import 'package:agendamentos/pages/item/bloc/item_query_bloc.dart';
import 'package:agendamentos/pages/item/bloc/item_query_event.dart';
import 'package:agendamentos/pages/item/bloc/item_query_state.dart';
import 'package:agendamentos/pages/item/product/query/product_query.dart';
import 'package:agendamentos/pages/item/service/query/service_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemQuery extends StatelessWidget {
  const ItemQuery({Key? key}) : super(key: key);

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
                const ListTile(
                  leading: Icon(Icons.handyman_outlined),
                  title: Text('Produto'),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.home_repair_service),
                  title: Text('Serviço'),
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
    String title = 'Produtos';
    return BlocBuilder(
      bloc: BlocProvider.of<ItemQueryBloc>(context),
      builder: (_, state) {
        var bloc = BlocProvider.of<ItemQueryBloc>(context);
        if (state is ItemQueryStateChangeTitle) {
          title = state.title;
        }
        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              bottom: TabBar(
                onTap: (index) => bloc.add(ItemQueryEventHandleTitle(index)),
                tabs: const [
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
