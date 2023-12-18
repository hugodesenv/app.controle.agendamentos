import 'package:agendamentos/enum/item_tipo_enum.dart';
import 'package:agendamentos/features/item/produto/produto_novo_provider.dart';
import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:agendamentos/widgets/text_field/skedol_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProdutoNovoPage extends StatefulWidget {
  const ProdutoNovoPage({super.key});

  @override
  State<ProdutoNovoPage> createState() => _ProdutoNovoPageState();
}

class _ProdutoNovoPageState extends State<ProdutoNovoPage> {
  late final ProdutoNovoProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<ProdutoNovoProvider>();
    provider.iniciarItem(ItemTipo.PRODUTO);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _actionButton(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Incluir produto'),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SkedolTextField(
            autoFocus: true,
            icone: Icons.description_outlined,
            onChange: (valor) => provider.onChangeDescricao(valor),
            titulo: 'Descrição',
          ),
        ],
      ),
    );
  }

  FloatingActionButton _actionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.save_outlined),
      onPressed: () {
        provider.gravar();
      },
    );
  }
}
