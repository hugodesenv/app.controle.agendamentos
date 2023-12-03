mixin AgendaValidacaoMixin {
  String? profissionalVazio(String value) {
    if (value.isEmpty) {
      return 'Profissional é obrigatório!';
    }
    return null;
  }

  String? clienteVazio(String value) {
    if (value.isEmpty) {
      return 'Cliente é obrigatório!';
    }
    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (var func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }

    return null;
  }
}
