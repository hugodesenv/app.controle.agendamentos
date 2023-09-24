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

enum ScheduleFromText { tDescription, tColor }

class ScheduleUtils {
  static Map<ScheduleFromText, dynamic> fromText(String situation) {
    if (situation == ScheduleSituationEnum.PENDING.text()) {
      return {
        ScheduleFromText.tDescription: 'Pendente',
        ScheduleFromText.tColor: Colors.orange,
      };
    } else if (situation == ScheduleSituationEnum.CANCELED.text()) {
      return {
        ScheduleFromText.tDescription: 'Cancelado',
        ScheduleFromText.tColor: Colors.red,
      };
    } else if (situation == ScheduleSituationEnum.CONFIRMED.text()) {
      return {
        ScheduleFromText.tDescription: 'Confirmado',
        ScheduleFromText.tColor: Colors.teal,
      };
    } else if (situation == ScheduleSituationEnum.PROGRESS.text()) {
      return {
        ScheduleFromText.tDescription: 'Em andamento',
        ScheduleFromText.tColor: Colors.purpleAccent,
      };
    } else if (situation == ScheduleSituationEnum.COMPLETED.text()) {
      return {
        ScheduleFromText.tDescription: 'Finalizado',
        ScheduleFromText.tColor: Colors.blue,
      };
    } else {
      return {
        ScheduleFromText.tDescription: 'Indefinido',
        ScheduleFromText.tColor: Colors.grey,
      };
    }
  }
}
