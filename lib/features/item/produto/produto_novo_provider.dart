import 'package:agendamentos/enum/item_tipo_enum.dart';
import 'package:agendamentos/models/item.dart';
import 'package:agendamentos/repository/item_repository.dart';
import 'package:agendamentos/utils/preferences_util.dart';
import 'package:flutter/material.dart';

class ProdutoNovoProvider with ChangeNotifier {
  Item _item = Item.empty();

  void gravar() async {
    final repository = ItemRepository.instance;
    final res = await repository.save(_item);
    print(
        "** gravar produto novo provider depois de salvar... ${res} -> mensagem dentro de produto_novo_provider.gravar");
  }

  onChangeDescricao(String? novaDescricao) {
    _item = _item.copyWith(descricao: novaDescricao ?? '');
  }

  Future<void> iniciarItem(ItemTipo pItemTipo) async {
    final usuarioAtual = await PreferencesUtil.usuarioAtual();

    _item = _item.copyWith(
      tipo: pItemTipo,
      empresa: usuarioAtual.empresa,
    );
  }
}
