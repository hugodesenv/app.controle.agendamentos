import 'package:agendamentos/assets/colorConstantes.dart';
import 'package:agendamentos/assets/utilsConstantes.dart';
import 'package:agendamentos/model/item.dart';
import 'package:agendamentos/pages/item/query/bloc/item_bloc.dart';
import 'package:agendamentos/pages/item/query/bloc/item_event.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/my_search_text_field/my_search_text_field.dart';
import '../query/bloc/item_state.dart';

class ItemQuery extends StatelessWidget {
  final TextEditingController _productBarcodeController = TextEditingController();
  final TextEditingController _hourTimeController = TextEditingController();

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

  _onTapBarcode(ItemBloc bloc) {
    bloc.add(ItemEventShowBarCode());
  }

  _saveProduct(ItemBloc bloc) {
    // Passing manually controllers values and others attributes to the BloC.
    bloc.add(ItemEventSetValues(
      barcode: _productBarcodeController.text,
      type: ItemType.product,
    ));
    bloc.add(ItemEventSave());
  }

  Future _onTapProduct(BuildContext context, ItemBloc bloc) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: shapeModalBottomSheet,
      builder: (_) {
        return BlocListener(
          bloc: bloc,
          listener: (_, state) {
            if (state is ItemStateHandleBarCode) {
              _productBarcodeController.text = state.value;
            }
          },
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              return Form(
                key: bloc.formKeyMain,
                child: Padding(
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text('Novo produto', style: textStyleTitleModalBottomSheet(context)),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: _productBarcodeController,
                                decoration: const InputDecoration(
                                  labelText: 'Código de barras',
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _onTapBarcode(bloc),
                              icon: Icon(Icons.qr_code, color: primaryColor(context)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          onChanged: (value) => bloc.add(ItemEventSetValues(description: value)),
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _saveProduct(bloc),
                        child: const Text('Gravar'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Novo serviço', style: textStyleTitleModalBottomSheet(context)),
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
                  controller: _hourTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Tempo',
                    border: UnderlineInputBorder(),
                    suffixIcon: Icon(Icons.timer_sharp),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    HoraInputFormatter(),
                  ],
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
        builder: (context) {
          return ScaffoldMessenger(
            child: Builder(
              builder: (context) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: BlocListener(
                    bloc: bloc,
                    listener: (_, state) {
                      if (state is ItemStateSuccess) {
                        mySnackbar(context, state.message);
                        Navigator.pop(context);
                      } else if (state is ItemStateFailure) {
                        mySnackbar(context, state.error, background: Colors.red);
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('O que deseja cadastrar?', style: textStyleTitleModalBottomSheet(context)),
                          ),
                          const Divider(),
                          ListTile(
                            title: Text('Produto', style: TextStyle(color: primaryColor(context))),
                            leading: Icon(Icons.hardware_outlined, color: primaryColor(context)),
                            onTap: () async => await _onTapProduct(context, bloc),
                          ),
                          ListTile(
                            title: Text('Serviço', style: TextStyle(color: primaryColor(context))),
                            leading: Icon(Icons.home_repair_service_outlined, color: primaryColor(context)),
                            onTap: () async => await _onTapService(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  final List<Tab> _tabsIcon = [
    const Tab(icon: Icon(Icons.hardware_outlined, color: Colors.black)),
    const Tab(icon: Icon(Icons.work_history_outlined, color: Colors.black)),
  ];

  Widget _firstTab(ItemBloc bloc) {
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, state) {
        bool loading = state is ItemStateLoading;
        List<Item> items = [];
        if (state is ItemStateRefreshList) {
          items.clear();
          items.addAll(state.items);
        }
        return Container(
          padding: const EdgeInsets.all(10),
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : items.isEmpty
                  ? const Center(child: Text('Nenhum registro encontrado'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
                          child: MySearchTextField(
                            labelText: 'Filtrar produtos...',
                            onChanged: (value) => print("** digitado: $value"),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: items.length,
                            separatorBuilder: (_, index) => const Divider(),
                            itemBuilder: (_, index) {
                              Item item = items[index];
                              return ListTile(
                                title: Text(item.description),
                                subtitle: Text(item.barcode),
                                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 10),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }

  Widget _secondTab() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
            child: MySearchTextField(
              labelText: 'Filtrar serviços...',
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ItemBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos e serviços'),
        actions: _actionAppBar(context, bloc),
      ),
      body: DefaultTabController(
        length: _tabsIcon.length,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: TabBar(tabs: _tabsIcon),
          ),
          body: TabBarView(
            children: [
              _firstTab(bloc),
              _secondTab(),
            ],
          ),
        ),
      ),
    );
  }
}