enum AgendamentoSituacao {
  PENDENTE,
  CONFIRMADO,
  EM_PROGRESSO,
  CANCELADO,
  FINALIZADO,
  INDEFINIDO,
}

extension AgendamentoSituacaoEnumExtensao on AgendamentoSituacao {
  String text() {
    switch (this) {
      case AgendamentoSituacao.CANCELADO:
        return 'canceled';
      case AgendamentoSituacao.FINALIZADO:
        return 'completed';
      case AgendamentoSituacao.CONFIRMADO:
        return 'confirmed';
      case AgendamentoSituacao.EM_PROGRESSO:
        return 'progress';
      case AgendamentoSituacao.PENDENTE:
        return 'pending';
      default:
        return 'undefined';
    }
  }
}
