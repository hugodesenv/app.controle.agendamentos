import 'package:agendamentos/pages/item/product/new/bloc/product_new_event.dart';
import 'package:agendamentos/pages/item/product/new/bloc/product_new_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ProductNewBloc extends Bloc<ProductNewEvent, ProductNewState> {
  ProductNewBloc(super.initialState) {
    on<OpenCameraBarcodeEvent>(_openBarcodeCamera);
    on<SubmitEvent>(_submit);
  }

  Future _openBarcodeCamera(event, emit) async {
    String barcode = await FlutterBarcodeScanner.scanBarcode('#ff0000', 'Sair', true, ScanMode.DEFAULT);
    emit(state.copyWith(barcode: barcode));
  }

  _submit(event, emit) {
    print("** salvar o produto no banco aki");
  }
}
