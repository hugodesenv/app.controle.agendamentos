import 'package:agendamentos/model/customer.dart';
import 'package:flutter/material.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({Key? key, required this.customer}) : super(key: key);
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Info")),
      body: Column(
        children: [
          Text("Nome"),
          Text(customer.name),
        ],
      ),
    );
  }
}
