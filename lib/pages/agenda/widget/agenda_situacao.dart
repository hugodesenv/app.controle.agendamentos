import 'package:flutter/material.dart';

import '../../../enum/agendamento_situacao_enum.dart';
import '../../../models/schedule.dart';
import '../../../widgets/my_text_title.dart';

// ignore: must_be_immutable
class AgendaSituacao extends StatefulWidget {
  late Function({String? text, AgendamentoSituacao? situation}) _onResult;

  AgendaSituacao({
    Key? key,
    required Function({String? text, AgendamentoSituacao? situation}) onResult,
  }) : super(key: key) {
    _onResult = onResult;
  }

  @override
  State<AgendaSituacao> createState() => _AgendaSituacaoState();
}

class _AgendaSituacaoState extends State<AgendaSituacao> {
  AgendamentoSituacao? _situationGroup = AgendamentoSituacao.pendente;
  List components = [];

  @override
  void initState() {
    super.initState();
    buildList();

    widget._onResult(
      situation: AgendamentoSituacao.pendente,
      text: AgendamentoSituacao.pendente.text(),
    );
  }

  void buildList() {
    components.clear();
    for (var type in AgendamentoSituacao.values) {
      var situation = Schedule.fromText(type.text());
      var wrapper = {'type': type, ...situation};
      components.add(wrapper);
    }
  }

  TextStyle titleStyle(
      AgendamentoSituacao commingSituation, Color commingColor) {
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
            AgendamentoSituacao situationType = e['type'];
            Color situationColor = e[ScheduleFromText.tColor];

            return ListTile(
              title: Text(
                e[ScheduleFromText.tDescription],
                style: titleStyle(situationType, situationColor),
              ),
              leading: Radio<AgendamentoSituacao>(
                value: situationType,
                groupValue: _situationGroup,
                activeColor: situationColor,
                onChanged: (value) {
                  setState(
                    () {
                      _situationGroup = value;

                      widget._onResult(
                        text: _situationGroup?.text(),
                        situation: _situationGroup,
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
