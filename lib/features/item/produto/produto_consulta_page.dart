import 'package:agendamentos/enum/item_tipo_enum.dart';
import 'package:agendamentos/features/item/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/widgetsConstantes.dart';

class ProdutoConsultaPage extends StatefulWidget {
  const ProdutoConsultaPage({Key? key}) : super(key: key);

  @override
  State<ProdutoConsultaPage> createState() => _ProdutoConsultaPageState();
}

class _ProdutoConsultaPageState extends State<ProdutoConsultaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_addPostFrameCallback);
  }

  void _addPostFrameCallback(_) {
    context.read<ItemProvider>().tituloAppBar = 'Produto';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer<ItemProvider>(
          builder: (_, provider, __) {
            final itens = provider.filtrarItens(ItemTipo.PRODUTO);
            return Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final item = itens[index];
                  Color corTexto = item.active ? Colors.black : Colors.red;
                  return ListTile(
                    title: Text(
                      item.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: corTexto,
                      ),
                    ),
                    subtitle: Text(
                      item.obterDescricaoAtivo(),
                      style: TextStyle(color: corTexto),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 12.0),
                    onTap: () =>
                        mySnackbar(context, 'Clicamos no produto!! :)'),
                  );
                },
                separatorBuilder: (_, index) => const Divider(),
                itemCount: itens.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
