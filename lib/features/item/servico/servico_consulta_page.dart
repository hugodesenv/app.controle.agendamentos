import 'package:agendamentos/enum/item_tipo_enum.dart';
import 'package:agendamentos/features/item/item_provider.dart';
import 'package:agendamentos/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/widgetsConstantes.dart';

class ServicoConsultaPage extends StatefulWidget {
  const ServicoConsultaPage({Key? key}) : super(key: key);

  @override
  State<ServicoConsultaPage> createState() => _ServicoConsultaPageState();
}

class _ServicoConsultaPageState extends State<ServicoConsultaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_addPostFrameCallback);
  }

  void _addPostFrameCallback(_) {
    context.read<ItemProvider>().tituloAppBar = 'Serviço';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer<ItemProvider>(
          builder: (_, provider, __) {
            final servicos = provider.filtrarItens(ItemTipo.SERVICO);
            return Flexible(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  Item servico = servicos[index];
                  Color corTexto = servico.active ? Colors.black : Colors.red;
                  return ListTile(
                    title: Text(
                      servico.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: corTexto,
                      ),
                    ),
                    subtitle: Text(
                      servico.obterDescricaoAtivo(),
                      style: TextStyle(color: corTexto),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                    onTap: () =>
                        mySnackbar(context, 'Clicamos no serviço!! :)'),
                  );
                },
                separatorBuilder: (_, index) => const Divider(),
                itemCount: servicos.length,
              ),
            );
          },
        )
      ],
    );
  }
}
