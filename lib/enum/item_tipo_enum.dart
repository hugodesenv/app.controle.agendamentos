enum ItemTipo {
  INDEFINIDO,
  PRODUTO,
  SERVICO,
}

enum ItemTipoOpcoes { CODIGO, DESCRICAO }

extension ItemTipoExtensao on ItemTipo {
  String get typeCode => options()[ItemTipoOpcoes.CODIGO];
  String get typeDescription => options()[ItemTipoOpcoes.DESCRICAO];

  Map<ItemTipoOpcoes, dynamic> options() {
    switch (this) {
      case ItemTipo.PRODUTO:
        return {
          ItemTipoOpcoes.CODIGO: 'product',
          ItemTipoOpcoes.DESCRICAO: 'Produto',
        };
      case ItemTipo.SERVICO:
        return {
          ItemTipoOpcoes.CODIGO: 'service',
          ItemTipoOpcoes.DESCRICAO: 'Serviço',
        };
      default:
        return {
          ItemTipoOpcoes.CODIGO: 'undefined',
          ItemTipoOpcoes.DESCRICAO: 'Indefinido',
        };
    }
  }
}
