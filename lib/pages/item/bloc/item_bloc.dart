import 'package:agendamentos/model/product.dart';
import 'package:agendamentos/pages/item/bloc/item_event.dart';
import 'package:agendamentos/pages/item/bloc/item_state.dart';
import 'package:agendamentos/repository/item_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../../assets/colorConstantes.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  Product _product = Product.empty();
  final _formKeyMain = GlobalKey<FormState>();

  ItemBloc(super.initialState) {
    on<ItemEventShowBarCode>(_showBarCode);
    on<ItemEventSetValues>(_setValues);
    on<ItemEventSave>(_save);
  }

  get formKeyMain => _formKeyMain;

  /// show the barcode screen
  Future _showBarCode(ItemEventShowBarCode event, emit) async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(secondaryColorHex, 'Fechar', true, ScanMode.DEFAULT);
    if (barcode != '-1') {
      emit(ItemStateHandleBarCode(value: barcode));
    }
  }

  /// take the values from edit and pass to product object
  void _setValues(ItemEventSetValues event, emit) {
    _product = _product.copyWith(barcode: event.barcode, description: event.description);
  }

  /// persist the data in the database
  Future _save(ItemEventSave event, emit) async {
    var state = _formKeyMain.currentState!;
    state.save();

    try {
      if (state.validate()) {
        var repository = ItemRepository.instance;
        _product.id = await repository.productSave(_product);
        emit(ItemStateSuccess('Operação realizada com sucesso!'));
      }
    } catch (e) {
      emit(ItemStateFailure('Falha na inclusão do item'));
    }
  }
}
