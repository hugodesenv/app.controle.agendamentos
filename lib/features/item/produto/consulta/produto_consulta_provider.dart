import 'package:agendamentos/enum/item_tipo_enum.dart';
import 'package:agendamentos/repository/item_repository.dart';
import 'package:flutter/material.dart';
import '../../../../models/item.dart';

class ProdutoConsultaProvider with ChangeNotifier {
  List<Item> itens = [];

  Future<void> findItems() async {
    try {
      final mapItens = await ItemRepository.instance.findAll();
      itens = mapItens['itens'];
      notifyListeners();
    } catch (e) {}
  }

  List<Item> filterList(ItemTipo pType) =>
      itens.where((e) => e.tipo == pType).toList();
}
