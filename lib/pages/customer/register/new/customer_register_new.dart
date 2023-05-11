import 'package:flutter/material.dart';

class CustomerRegisterNew extends StatelessWidget {
  const CustomerRegisterNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novo")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text("Novo cliente"),
      ),
    );
  }
}
