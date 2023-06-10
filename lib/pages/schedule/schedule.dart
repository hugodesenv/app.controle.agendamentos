import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  List<Widget> _actions() {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.save_outlined),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar'),
        actions: _actions(),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 8.0, top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyModalSearch(
              title: 'Meus clientes',
              collection: 'person',
              columnShow: 'name',
              initialID: '3sRFp0emBKq0LmE0zJ4r', //para teste
              onSelected: (id, selected) {
                print("** dados retornados schedule.dart");
                print(selected);
                print(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
