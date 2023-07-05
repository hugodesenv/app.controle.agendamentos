import 'package:agendamentos/assets/utilsConstantes.dart';
import 'package:flutter/material.dart';

class ProductQuery extends StatelessWidget {
  const ProductQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: const Text('Produto'),
                subtitle: const Text('150,00'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                onTap: () => mySnackbar(context, 'Clicamos no produto!! :)'),
              );
            },
            separatorBuilder: (_, index) => const Divider(),
            itemCount: 40,
          ),
        ),
      ],
    );
  }
}
