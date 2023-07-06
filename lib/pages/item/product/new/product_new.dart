import 'package:flutter/material.dart';

import '../../../../assets/utilsConstantes.dart';

class ProductNew extends StatelessWidget {
  const ProductNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            'Novo produto',
            style: textStyleTitleModalBottomSheet(context),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
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
                    onPressed: () {},
                    icon: const Icon(Icons.qr_code_rounded),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save_outlined),
      ),
    );
  }
}
