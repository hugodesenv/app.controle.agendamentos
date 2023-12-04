enum AgendamentoSituacao {
  pendente,
  confirmado,
  emProgresso,
  cancelado,
  finalizado,
  indefinido,
}

extension AgendamentoSituacaoEnumExtensao on AgendamentoSituacao {
  String text() {
    switch (this) {
      case AgendamentoSituacao.cancelado:
        return 'canceled';
      case AgendamentoSituacao.finalizado:
        return 'completed';
      case AgendamentoSituacao.confirmado:
        return 'confirmed';
      case AgendamentoSituacao.emProgresso:
        return 'progress';
      case AgendamentoSituacao.pendente:
        return 'pending';
      default:
        return 'undefined';
    }
  }
}
