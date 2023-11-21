import 'package:agendamentos/pages/schedules/bloc/schedule_bloc.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:agendamentos/pages/schedules/widgets/schedule.items.dart';
import 'package:agendamentos/pages/schedules/widgets/schedule.situation.dart';
import 'package:agendamentos/widgets/my_date_field.dart';
import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../enum/schedule_situation_enum.dart';
import '../../widgets/my_modal_search/enum/my_modal_search_enum.dart';

class ScheduleParameters {
  DateTime? scheduleDate;
  ScheduleParameters({required this.scheduleDate});
}

class Schedule extends StatelessWidget with FormvScheduleMixin {
  Schedule({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ScheduleBloc>(context),
      builder: (_, ScheduleState state) {
        var bloc = BlocProvider.of<ScheduleBloc>(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Compromisso'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 8.0,
                top: 20.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyModalSearch(
                      typeSearch: MyModalSearchEnum.tEmployee,
                      initialValue: state.schedule.employee.name,
                      validator: (message) => combine([
                        () => employeeIsEmpty(message ?? ''),
                      ]),
                      onTap: (model) {
                        bloc.add(EmployeeChange(model));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: MyModalSearch(
                        typeSearch: MyModalSearchEnum.tCustomer,
                        validator: (message) => combine([
                          () => customerIsEmpty(message ?? ''),
                        ]),
                        initialValue: state.schedule.customer.name,
                        onTap: (model) {
                          bloc.add(CustomerChange(model));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: MyDateField(
                        title: 'Data / Hora',
                        initialValue: state.schedule.scheduleDate,
                        onChanged: (DateTime? selectedDate) =>
                            bloc.add(ScheduleDateChange(selectedDate)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: ScheduleItems(),
                    ),
                    SituationRadioGroup(
                      onResult: (
                          {ScheduleSituationEnum? enumuerator, String? text}) {
                        bloc.add(SituationChange(enumuerator));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save_outlined),
            onPressed: () => _formSave(),
          ),
        );
      },
    );
  }

  void _formSave() {
    if (_formKey.currentState!.validate() == false) return;
  }
}

mixin FormvScheduleMixin {
  String? employeeIsEmpty(String value) {
    if (value.isEmpty) {
      return 'Profissional é obrigatório!';
    }
    return null;
  }

  String? customerIsEmpty(String value) {
    if (value.isEmpty) {
      return 'Cliente é obrigatório!';
    }
    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (var func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }

    return null;
  }
}
