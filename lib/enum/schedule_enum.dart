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
