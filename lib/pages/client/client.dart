import 'package:flutter/material.dart';

class Client extends StatelessWidget {
  const Client({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return ListTile(
              title: const Text(
                "Hugo Souza",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text("(19) 9 8961-5184"),
              onTap: () {
                print("Olá");
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 25),
    );
  }
}
