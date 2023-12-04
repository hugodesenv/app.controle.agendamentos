enum BancoDadosAcoes { inclusao, alteracao, exclusao }

extension DabaseActionExtension on BancoDadosAcoes {
  String text() {
    switch (this) {
      case BancoDadosAcoes.inclusao:
        return 'insert';
      case BancoDadosAcoes.alteracao:
        return 'update';
      case BancoDadosAcoes.exclusao:
        return 'delete';
      default:
        return 'undefined';
    }
  }
}
