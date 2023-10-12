import 'package:flutter/material.dart';

import '../../../utils/schedule_utils.dart';
import '../../../widgets/my_text_title.dart';

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
                  setState(
                    () {
                      _situationGroup = value;

                      widget._onResult(
                        text: _situationGroup?.text(),
                        enumuerator: _situationGroup,
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
