import 'package:agendamentos/enum/item_tipo_enum.dart';
import 'package:agendamentos/features/item/produto/consulta/produto_consulta_provider.dart';
import 'package:agendamentos/models/item.dart';
import 'package:agendamentos/widgets/my_search_text_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/widgetsConstantes.dart';

class ProdutoConsultaPage extends StatefulWidget {
  const ProdutoConsultaPage({Key? key}) : super(key: key);

  @override
  State<ProdutoConsultaPage> createState() => _ProdutoConsultaPageState();
}

class _ProdutoConsultaPageState extends State<ProdutoConsultaPage> {
  late final ProdutoConsultaProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<ProdutoConsultaProvider>();
    WidgetsBinding.instance.addPostFrameCallback(onAfterBuild);
  }

  onAfterBuild(Duration pDuration) async {
    await provider.findItems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: MySearchTextField(
            onChanged: (value) {},
            labelText: 'Filtrar produto...',
          ),
        ),
        _itemsList(),
      ],
    );
  }

  Widget _itemsList() {
    return Consumer<ProdutoConsultaProvider>(
      builder: (context, provider, _) {
        final itens = provider.filterList(ItemTipo.PRODUTO);
        return Flexible(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final item = itens[index];
              return ListTile(
                title: Text(item.description),
                subtitle: Text(Item.obterDescricaoEnumTipo(item.tipo)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                onTap: () => mySnackbar(context, 'Clicamos no produto!! :)'),
              );
            },
            separatorBuilder: (_, index) => const Divider(),
            itemCount: itens.length,
          ),
        );
      },
    );
  }
}
