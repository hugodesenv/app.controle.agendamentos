import 'package:flutter/material.dart';

class Relatorio extends StatelessWidget {
  const Relatorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório'),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
