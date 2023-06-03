import 'package:agendamentos/pages/item/bloc/item_event.dart';
import 'package:agendamentos/pages/item/bloc/item_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../../assets/colorConstantes.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc(super.initialState) {
    on<ItemEventShowBarCode>(_showBarCode);
  }

  Future _showBarCode(ItemEventShowBarCode event, emit) async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(secondaryColorHex, 'Fechar', true, ScanMode.DEFAULT);

    if (barcode != '-1') {
      emit(ItemStateHandleBarCode(value: barcode));
    }
  }
}
