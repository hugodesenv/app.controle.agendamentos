import 'package:agendamentos/mixin/form_validation/schedule_form_validation_mixin.dart';
import 'package:agendamentos/pages/schedules/schedule_items.dart';
import 'package:agendamentos/pages/schedules/widgets/schedule.situation.dart';
import 'package:agendamentos/provider/schedule_provider.dart';
import 'package:agendamentos/widgets/my_date_field.dart';
import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_modal_search/enum/my_modal_search_enum.dart';

class ScheduleParameters {
  DateTime? scheduleDate;
  ScheduleParameters({required this.scheduleDate});
}

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with ScheduleFormValidationMixin {
  final _formKey = GlobalKey<FormState>();

  AppBar appBar() {
    return AppBar(title: const Text('Compromisso'));
  }

  body(BuildContext context) {
    var provider = context.read<ScheduleProvider>();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 8.0,
          top: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyModalSearch(
              typeSearch: MyModalSearchEnum.tEmployee,
              initialValue: provider.schedule.employee.name,
              validator: (message) => combine([
                () => employeeIsEmpty(message ?? ''),
              ]),
              onTap: (model) => provider.changeEmployee(model),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: MyModalSearch(
                typeSearch: MyModalSearchEnum.tCustomer,
                validator: (message) => combine([
                  () => customerIsEmpty(message ?? ''),
                ]),
                initialValue: provider.schedule.customer.name,
                onTap: (model) => provider.changeCustomer(model),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: MyDateField(
                title: 'Data / Hora',
                initialValue: provider.schedule.scheduleDate,
                onChanged: (DateTime? selectedDate) =>
                    provider.changeDate(selectedDate),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: ScheduleItems(),
            ),
            SituationRadioGroup(
              onResult: ({situation, text}) {
                provider.changeSituation(situation);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _formSave(BuildContext context) {
    if (_formKey.currentState!.validate() == false) {
      return;
    }

    context.read<ScheduleProvider>().save();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: appBar(),
          body: body(context),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save_outlined),
            onPressed: () => _formSave(context),
          ),
        );
      },
    );
  }
}
