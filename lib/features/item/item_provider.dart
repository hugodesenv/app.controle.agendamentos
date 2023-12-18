import 'package:agendamentos/enum/item_tipo_enum.dart';
import 'package:agendamentos/repository/item_repository.dart';
import 'package:flutter/material.dart';
import '../../models/item.dart';

class ItemProvider with ChangeNotifier {
  String _tituloAppBar = 'Meus produtos';
  List<Item> itens = [];

  String get tituloAppBar => _tituloAppBar;

  set tituloAppBar(String novoTitulo) {
    _tituloAppBar = novoTitulo;
    notifyListeners();
  }

  Future<void> buscarItens() async {
    try {
      final mapItens = await ItemRepository.instance.findAll();
      itens = mapItens['itens'];
      notifyListeners();
    } catch (e) {}
  }

  List<Item> filtrarItens(ItemTipo pType) =>
      itens.where((e) => e.tipo == pType).toList();
}
