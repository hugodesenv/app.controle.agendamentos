import 'package:agendamentos/widgets/my_date_field/my_date_field.dart';
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
      appBar: AppBar(title: const Text('Agendar')),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyModalSearch(
              title: 'Meus clientes',
              fieldTitle: 'Cliente',
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
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: MyDateField(
                title: 'Data / Hora',
                onChanged: (selectedDate) {
                  print("** ${selectedDate}");
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Gravar'),
        ),
      ),
    );
  }
}

class ScheduleParameters {
  DateTime scheduleDate;

  ScheduleParameters({DateTime? scheduleDate}) : scheduleDate = scheduleDate ?? DateTime.now();
}
