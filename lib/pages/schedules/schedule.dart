import 'package:agendamentos/enum/form_submission_status.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_bloc.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_event.dart';
import 'package:agendamentos/pages/schedules/bloc/schedule_state.dart';
import 'package:agendamentos/utils/constants/widgetsConstantes.dart';
import 'package:agendamentos/widgets/my_date_field.dart';
import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:agendamentos/widgets/my_text_field.dart';
import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/schedule_utils.dart';
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
            actions: [
              IconButton(
                icon: const Icon(Icons.save_outlined),
                onPressed: () {
                  if (state.formStatus != FormSubmissionStatus.inProgress) {
                    bloc.add(SendToDB());
                  }
                },
              )
            ],
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
                    onTap: (String id, String lookup) {
                      bloc.add(EmployeeChange(id, lookup));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: MyModalSearch(
                      typeSearch: MyModalSearchEnum.tCustomer,
                      initialValue: state.schedule.customer.name,
                      onTap: (String id, String lookup) {
                        bloc.add(CustomerChange(id, lookup));
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
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _ScheduleItems(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SituationRadioGroup(
                      onResult: (
                          {ScheduleSituationEnum? enumuerator, String? text}) {
                        bloc.add(SituationChange(enumuerator));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SituationRadioGroup extends StatefulWidget {
  late Function({String? text, ScheduleSituationEnum? enumuerator}) _onResult;

  SituationRadioGroup({
    Key? key,
    required Function({String? text, ScheduleSituationEnum? enumuerator})
        onResult,
  }) : super(key: key) {
    _onResult = onResult;
  }

  @override
  State<SituationRadioGroup> createState() => _SituationRadioGroupState();
}

class _SituationRadioGroupState extends State<SituationRadioGroup> {
  ScheduleSituationEnum? _situationGroup = ScheduleSituationEnum.PENDING;
  List components = [];

  @override
  void initState() {
    super.initState();
    buildList();

    widget._onResult(
      enumuerator: ScheduleSituationEnum.PENDING,
      text: ScheduleSituationEnum.PENDING.text(),
    );
  }

  void buildList() {
    components.clear();
    for (var type in ScheduleSituationEnum.values) {
      var situation = ScheduleUtils.fromText(type.text());
      var wrapper = {'type': type, ...situation};
      components.add(wrapper);
    }
  }

  TextStyle titleStyle(
      ScheduleSituationEnum commingSituation, Color commingColor) {
    bool isOK = commingSituation == _situationGroup;
    return TextStyle(
      fontSize: 15.0,
      color: isOK ? commingColor : Colors.black,
      fontWeight: isOK ? FontWeight.w700 : FontWeight.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyTextTitle(title: 'Situação'),
        ...components.map(
          (e) {
            ScheduleSituationEnum situationType = e['type'];
            Color situationColor = e[ScheduleFromText.tColor];

            return ListTile(
              title: Text(
                e[ScheduleFromText.tDescription],
                style: titleStyle(situationType, situationColor),
              ),
              leading: Radio<ScheduleSituationEnum>(
                value: situationType,
                groupValue: _situationGroup,
                activeColor: situationColor,
                onChanged: (value) {
                  setState(() {
                    _situationGroup = value;

                    widget._onResult(
                      text: _situationGroup?.text(),
                      enumuerator: _situationGroup,
                    );
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ScheduleItems extends StatefulWidget {
  _ScheduleItems({Key? key}) : super(key: key);

  List _items = [
    {
      'description': 'Corte de cabelo',
    },
    {
      'description': 'Maquiagem',
    }
  ];

  @override
  State<_ScheduleItems> createState() => _ScheduleItemsState();
}

class _ScheduleItemsState extends State<_ScheduleItems> {
  Future<void> modalAddItems() async {
    await showModalBottomSheet(
      context: context,
      shape: shapeModalBottomSheet,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: MyModalSearch(
                    typeSearch: MyModalSearchEnum.tItem,
                    onTap: (String id, String lookup) {},
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: MyTextField(
                          title: 'Valor',
                          suffixIcon:
                              const Icon(Icons.monetization_on_outlined),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: MyTextField(
                          title: 'Tempo',
                          suffixIcon: const Icon(Icons.timer_sharp),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.save_outlined),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyTextTitle(title: 'Adicionar itens'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async => await modalAddItems(),
            ),
          ],
        ),
        ...widget._items.map((e) {
          return ListTile(
            title: Text(
              e['description'],
              style: const TextStyle(fontSize: 14.0),
            ),
            subtitle: const Text('Preço: 12.0 / Tempo: 120'),
            contentPadding: EdgeInsets.zero,
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outlined,
                color: Colors.black38,
              ),
            ),
          );
        }),
        const Divider(),
        const Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Text(
            'Tempo total: 1h30 / Valor total: R\$129,90',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
