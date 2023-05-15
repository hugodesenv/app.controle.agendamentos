import 'package:flutter/material.dart';

class CustomerNew extends StatelessWidget {
  const CustomerNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novo")),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).highlightColor,
        child: Text("Novo cliente"),
      ),
    );
  }
}
