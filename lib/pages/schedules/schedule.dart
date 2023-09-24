import 'package:agendamentos/widgets/my_date_field.dart';
import 'package:agendamentos/widgets/my_modal_search/my_modal_search.dart';
import 'package:agendamentos/widgets/my_text_title.dart';
import 'package:flutter/material.dart';

import '../../utils/schedule_utils.dart';
import '../../widgets/my_modal_search/enum/my_modal_search_enum.dart';

class ScheduleParameters {
  DateTime scheduleDate;

  ScheduleParameters({DateTime? scheduleDate}) : scheduleDate = scheduleDate ?? DateTime.now();
}

class Schedule extends StatefulWidget {
  late ScheduleParameters? _parameters;

  Schedule({Key? key, required ScheduleParameters? parameters})
      : _parameters = parameters,
        super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendar')),
      body: SingleChildScrollView(
        child: Padding(
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
                padding: const EdgeInsets.only(top: 16.0),
                child: SituationRadioGroup(
                  onClick: ({ScheduleSituationEnum? enumuerator, String? text}) {
                    print("** click no radio group... usar para salvar na api...");
                    print("** ${enumuerator.toString()}");
                    print("** ${text}");
                    print("---------------------------------------------------------");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Gravar'),
        ),
      ),
    );
  }
}

class SituationRadioGroup extends StatefulWidget {
  late Function({String? text, ScheduleSituationEnum? enumuerator}) _onClick;

  SituationRadioGroup({
    Key? key,
    required Function({String? text, ScheduleSituationEnum? enumuerator}) onClick,
  }) : super(key: key) {
    _onClick = onClick;
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
  }

  void buildList() {
    components.clear();
    for (var type in ScheduleSituationEnum.values) {
      var situation = ScheduleUtils.fromText(type.text());
      var wrapper = {'type': type, ...situation};
      components.add(wrapper);
    }
  }

  TextStyle titleStyle(ScheduleSituationEnum commingSituation, Color commingColor) {
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
        MyTextTitle(title: 'Situações'),
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

                    widget._onClick(
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
