import 'package:agendamentos/assets/colorConstantes.dart';
import 'package:agendamentos/assets/utilsConstantes.dart';
import 'package:agendamentos/pages/item/bloc/item_bloc.dart';
import 'package:agendamentos/pages/item/bloc/item_event.dart';
import 'package:agendamentos/widgets/text/myTextTitleBottomSheet.dart';
import 'package:agendamentos/widgets/text_field/my_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/item_state.dart';

class ItemQuery extends StatelessWidget {
  final TextEditingController _barcodeController = TextEditingController();

  ItemQuery({Key? key}) : super(key: key);

  List<Widget> _actionAppBar(BuildContext context, ItemBloc bloc) {
    return [
      PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text('Novo'),
            onTap: () async => await _onTapNew(context, bloc),
          ),
        ],
      ),
    ];
  }

  _onTapBarcode(ItemBloc bloc) async {
    bloc.add(ItemEventShowBarCode());
  }

  Future _onTapProduct(BuildContext context, ItemBloc bloc) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: shapeModalBottomSheet,
      builder: (_) {
        return BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is ItemStateHandleBarCode) {
              _barcodeController.text = state.value;
            }
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: MyTextTitleBottomSheet(title: 'Novo produto'),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _barcodeController,
                            decoration: const InputDecoration(
                              labelText: 'Código',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _onTapBarcode(bloc),
                          icon: const Icon(
                            Icons.qr_code,
                            color: Color(primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Gravar'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future _onTapService(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: shapeModalBottomSheet,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: MyTextTitleBottomSheet(title: 'Novo serviço'),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tempo',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.timer_sharp),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Gravar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _onTapNew(BuildContext context, ItemBloc bloc) async {
    await Future.delayed(
      zeroDuration,
      () async => await showModalBottomSheet(
        shape: shapeModalBottomSheet,
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: MyTextTitleBottomSheet(title: 'O que deseja cadastrar?'),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Produto', style: TextStyle(color: Color(primaryColor))),
                  leading: const Icon(Icons.hardware_outlined, color: Color(primaryColor)),
                  onTap: () async => await _onTapProduct(context, bloc),
                ),
                ListTile(
                  title: const Text('Serviço', style: TextStyle(color: Color(primaryColor))),
                  leading: const Icon(Icons.home_repair_service_outlined, color: Color(primaryColor)),
                  onTap: () async => await _onTapService(context),
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
    var bloc = BlocProvider.of<ItemBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itens'),
        actions: _actionAppBar(context, bloc),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
                  child: MySearchTextField(
                    onChanged: (value) => print("** digitado: $value"),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 40,
                    separatorBuilder: (_, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return const ListTile(
                        title: Text('Tesoura'),
                        subtitle: Text('R\$10,00'),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 10,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
