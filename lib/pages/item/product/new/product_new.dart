import 'package:agendamentos/pages/item/product/new/bloc/product_new_bloc.dart';
import 'package:agendamentos/pages/item/product/new/bloc/product_new_event.dart';
import 'package:agendamentos/pages/item/product/new/bloc/product_new_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/utilsConstantes.dart';

class ProductNew extends StatelessWidget {
  const ProductNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductNewBloc(ProductNewState()),
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text(
              'Novo produto',
              style: textStyleTitleModalBottomSheet(context),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            var bloc = BlocProvider.of<ProductNewBloc>(context);
            return BlocBuilder(
              bloc: bloc,
              builder: (_, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Descrição'),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Código de barras'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: IconButton(
                              onPressed: () => bloc.add(OpenCameraBarcodeEvent()),
                              icon: const Icon(Icons.qr_code_rounded),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var bloc = BlocProvider.of<ProductNewBloc>(context);
            bloc.add(SubmitEvent());////deu ruim pq ta fora
          },
          child: const Icon(Icons.save_outlined),
        ),
      ),
    );
  }
}
