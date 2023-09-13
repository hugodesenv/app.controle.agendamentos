/// Classe responsável para tratar conversoes de String para elementos Colors.
/// Apenas isso...
/// Assistindo o jogo do Brasil contra o Peru 13/09/2023 00h34

import 'package:flutter/material.dart';
import '../enum/schedule_situation.dart';

class ToColorUtils {
  static Color scheduleSituation(String situation) {
    if (situation == ScheduleSituationEnum.CONFIRMED.text()) {
      return Colors.green;
    } else if (situation == ScheduleSituationEnum.PROGRESS.text()) {
      return Colors.amber;
    } else if (situation == ScheduleSituationEnum.CANCELED.text()) {
      return Colors.redAccent;
    } else if (situation == ScheduleSituationEnum.COMPLETED.text()) {
      return Colors.lightBlueAccent;
    } else {
      return Colors.grey;
    }
  }
}
