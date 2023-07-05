import 'package:agendamentos/assets/utilsConstantes.dart';
import 'package:flutter/material.dart';

class ServiceQuery extends StatelessWidget {
  const ServiceQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: const Text('Serviço'),
                subtitle: const Text('1h40'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 12),
                onTap: () => mySnackbar(context, 'Clicamos no serviço!! :)'),
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
