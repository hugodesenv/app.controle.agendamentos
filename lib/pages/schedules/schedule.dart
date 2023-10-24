import 'package:agendamentos/enum/form_submission_status.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_bloc.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:agendamentos/pages/schedules/widgets/schedule.items.dart';
import 'package:agendamentos/pages/schedules/widgets/schedule.situation.dart';
import 'package:agendamentos/widgets/my_date_field.dart';
import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/customer.dart';
import '../../utils/api/schedule_utils.dart';
import '../../widgets/my_field_text.dart';
import '../../widgets/my_modal_search/enum/my_modal_search_enum.dart';

class ScheduleParameters {
  DateTime? scheduleDate;
  ScheduleParameters({required this.scheduleDate});
}

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MyModalSearch(
                    typeSearch: MyModalSearchEnum.tEmployee,
                    initialValue: state.schedule.employee.name,
                    onTap: (model) {
                      bloc.add(EmployeeChange(model));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: MyModalSearch(
                      typeSearch: MyModalSearchEnum.tCustomer,
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
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save_outlined),
            onPressed: () {
              //if (state.formStatus != FormSubmissionStatus.inProgress) {
              bloc.add(SendToDB());
              //}
            },
          ),
        );
      },
    );
  }
}
