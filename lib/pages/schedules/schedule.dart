import 'package:agendamentos/widgets/my_date_field/my_date_field.dart';
import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_modal_search/enum/my_modal_search_enum.dart';

class ScheduleParameters {
  DateTime scheduleDate;

  ScheduleParameters({DateTime? scheduleDate}) : scheduleDate = scheduleDate ?? DateTime.now();
}

class Schedule extends StatelessWidget {
  late ScheduleParameters? _parameters;

  Schedule({Key? key, required ScheduleParameters? parameters})
      : _parameters = parameters,
        super(key: key);

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
              typeSearch: MyModalSearchEnum.CUSTOMER,
              initialValue: 'Hugo Souza',
              onTap: (String id) {
                print("** id do client selecionado: ${id}");
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: MyDateField(
                title: 'Data / Hora',
                onChanged: (selectedDate) {
                  print("** ${selectedDate}");
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: _situationsGroup(),
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

  Widget _situationsGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text('Situações', style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        ListTile(
          title: Text(''),
        ),
        ListTile(),
      ],
    );
  }
}
