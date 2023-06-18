import 'package:agendamentos/model/item.dart';
import 'package:agendamentos/pages/item/bloc/item_event.dart';
import 'package:agendamentos/pages/item/bloc/item_state.dart';
import 'package:agendamentos/repository/item_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../assets/colorConstantes.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  Item _product = Item.empty();
  final _formKeyMain = GlobalKey<FormState>();

  ItemBloc(super.initialState) {
    on<ItemEventShowBarCode>(_showBarCode);
    on<ItemEventSetValues>(_setValues);
    on<ItemEventSave>(_save);
    on<ItemEventFetchAll>(_fetchAll);
  }

  get formKeyMain => _formKeyMain;

  Future _showBarCode(ItemEventShowBarCode event, emit) async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(secondaryColorHex, 'Fechar', true, ScanMode.DEFAULT);
    if (barcode != '-1') {
      emit(ItemStateHandleBarCode(value: barcode));
    }
  }

  void _setValues(ItemEventSetValues event, emit) {
    _product = _product.copyWith(barcode: event.barcode, description: event.description);
  }

  Future _save(ItemEventSave event, emit) async {
    var state = _formKeyMain.currentState!;
    state.save();

    try {
      if (state.validate()) {
        var repository = ItemRepository.instance;
        _product.id = await repository.save(_product);
        emit(ItemStateSuccess('Operação realizada com sucesso!'));
      }
    } catch (e) {
      emit(ItemStateFailure('Falha na inclusão do item'));
    }
  }

  Future _fetchAll(ItemEventFetchAll event, emit) async {
    List<Item> items = [];
    try {
      emit(ItemStateLoading());
      ItemRepository repository = ItemRepository.instance;
      items = await repository.fetchAll() as List<Item>;
    } finally {
      emit(ItemStateRefreshList(items: items));
    }
  }
}
