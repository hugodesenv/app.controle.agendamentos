import 'package:flutter/material.dart';

enum ScheduleSituationEnum {
  PENDING,
  CONFIRMED,
  PROGRESS,
  CANCELED,
  COMPLETED,
  UNDEFINED,
}

extension ScheduleSituationEnumExtension on ScheduleSituationEnum {
  String text() {
    switch (this) {
      case ScheduleSituationEnum.CANCELED:
        return 'canceled';
      case ScheduleSituationEnum.COMPLETED:
        return 'completed';
      case ScheduleSituationEnum.CONFIRMED:
        return 'confirmed';
      case ScheduleSituationEnum.PROGRESS:
        return 'progress';
      case ScheduleSituationEnum.PENDING:
        return 'pending';
      default:
        return 'undefined';
    }
  }
}

enum ScheduleFromText { tDescription, tColor, tType }

class ScheduleUtils {
  static Map<ScheduleFromText, dynamic> fromText(String situation) {
    if (situation == ScheduleSituationEnum.PENDING.text()) {
      return {
        ScheduleFromText.tDescription: 'Pendente',
        ScheduleFromText.tColor: const Color.fromARGB(255, 173, 173, 173),
        ScheduleFromText.tType: ScheduleSituationEnum.PENDING,
      };
    } else if (situation == ScheduleSituationEnum.CANCELED.text()) {
      return {
        ScheduleFromText.tDescription: 'Cancelado',
        ScheduleFromText.tColor: Colors.red,
        ScheduleFromText.tType: ScheduleSituationEnum.CANCELED,
      };
    } else if (situation == ScheduleSituationEnum.CONFIRMED.text()) {
      return {
        ScheduleFromText.tDescription: 'Confirmado',
        ScheduleFromText.tColor: const Color.fromARGB(255, 130, 141, 209),
        ScheduleFromText.tType: ScheduleSituationEnum.CONFIRMED,
      };
    } else if (situation == ScheduleSituationEnum.PROGRESS.text()) {
      return {
        ScheduleFromText.tDescription: 'Em andamento',
        ScheduleFromText.tColor: Color.fromARGB(255, 106, 126, 240),
        ScheduleFromText.tType: ScheduleSituationEnum.PROGRESS,
      };
    } else if (situation == ScheduleSituationEnum.COMPLETED.text()) {
      return {
        ScheduleFromText.tDescription: 'Finalizado',
        ScheduleFromText.tColor: Colors.green,
        ScheduleFromText.tType: ScheduleSituationEnum.COMPLETED,
      };
    } else {
      return {
        ScheduleFromText.tDescription: 'Indefinido',
        ScheduleFromText.tColor: Colors.grey,
        ScheduleFromText.tType: ScheduleSituationEnum.UNDEFINED,
      };
    }
  }
}
