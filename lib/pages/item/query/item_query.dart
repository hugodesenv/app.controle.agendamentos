import 'package:flutter/material.dart';

class ItemQuery extends StatelessWidget {
  const ItemQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itens'),
      ),
      body: Container(
        child: Text("Puxar a listagem dos itens aqui dentro"),
      ),
    );
  }
}
