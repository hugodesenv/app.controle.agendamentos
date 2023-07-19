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
    String barcode = await FlutterBarcodeScanner.scanBarcode('#3a48e9', 'Sair', true, ScanMode.DEFAULT);
    print("** codigo de barras recuperado, continuar o procedimento: $barcode");
  }

  _submit(event, emit) {
    print("** salvar o produto no banco aki");
  }
}
