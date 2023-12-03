enum BancoDadosAcoes { INCLUSAO, ALTERACAO, EXCLUSAO }

extension DabaseActionExtension on BancoDadosAcoes {
  String text() {
    switch (this) {
      case BancoDadosAcoes.INCLUSAO:
        return 'insert';
      case BancoDadosAcoes.ALTERACAO:
        return 'update';
      case BancoDadosAcoes.EXCLUSAO:
        return 'delete';
      default:
        return 'undefined';
    }
  }
}
