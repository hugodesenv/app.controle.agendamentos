import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  late ScheduleParameters? _parameters;

  Schedule({Key? key, required ScheduleParameters? parameters})
      : _parameters = parameters,
        super(key: key) {
    print("** o que trouxemos aqui? ${_parameters?.scheduleDate.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar'),
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
              initialID: 'MhLENgGvwhAyug1ktDDE',
              //para teste
              onSelected: (id, selected) {
                print("** dados retornados schedule.dart");
                print(selected);
                print(id);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}

class ScheduleParameters {
  DateTime scheduleDate;

  ScheduleParameters({DateTime? scheduleDate}) : scheduleDate = scheduleDate ?? DateTime.now();
}
