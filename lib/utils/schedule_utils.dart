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

class ScheduleUtils {
  static Map fromText(String situation) {
    if (situation == ScheduleSituationEnum.PENDING.text()) {
      return {
        'description': 'Pendente',
        'color': Colors.orange,
      };
    } else if (situation == ScheduleSituationEnum.CANCELED.text()) {
      return {
        'description': 'Cancelado',
        'color': Colors.redAccent,
      };
    } else if (situation == ScheduleSituationEnum.CONFIRMED.text()) {
      return {
        'description': 'Confirmado',
        'color': Colors.blueAccent,
      };
    } else if (situation == ScheduleSituationEnum.PROGRESS.text()) {
      return {
        'description': 'Em andamento',
        'color': Colors.purpleAccent,
      };
    } else if (situation == ScheduleSituationEnum.COMPLETED.text()) {
      return {
        'description': 'Finalizado',
        'color': Colors.greenAccent,
      };
    } else {
      return {
        'description': 'Indefinido',
        'color': Colors.black,
      };
    }
  }
}
