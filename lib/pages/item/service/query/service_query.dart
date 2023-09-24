import 'package:flutter/material.dart';

import '../../../../utils/constants/widgetsConstantes.dart';
import '../../../../widgets/my_search_text_field.dart';

class ServiceQuery extends StatelessWidget {
  const ServiceQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: MySearchTextField(
            onChanged: (value) {},
            labelText: 'Filtrar serviço...',
          ),
        ),
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
