import '../enum/schedule_enum.dart';

/// Classe responsável para tratar conversões de display de tipos para nome amigável.
/// Apenas isso!

class DisplayFormatUtils {
  static String scheduleSituation(String situation) {
    if (situation == ScheduleSituationEnum.PENDING.text()) {
      return 'Pendente';
    } else if (situation == ScheduleSituationEnum.CANCELED.text()) {
      return 'Cancelado';
    } else if (situation == ScheduleSituationEnum.CONFIRMED.text()) {
      return 'Confirmado';
    } else if (situation == ScheduleSituationEnum.PROGRESS.text()) {
      return 'Em andamento';
    } else if (situation == ScheduleSituationEnum.COMPLETED.text()) {
      return 'Finalizado';
    } else {
      return 'Indefinido';
    }
  }
}
