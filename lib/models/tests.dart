class Tests {
  late String _id;
  late String _dataAvaliacao;
  late int _erros;
  late int _omissoes;
  late int _acertos;
  late int _qtdeCliques;
  late String _tipo;

  Tests(this._id, this._dataAvaliacao, this._erros, this._omissoes,
      this._acertos, this._qtdeCliques, this._tipo);

  String get id {
    return _id;
  }

  set sId(String id) {
    _id = id;
  }

  String get dataAvaliacao {
    return _dataAvaliacao;
  }

  set sDataAvaliacao(String dataAvaliacao) {
    _dataAvaliacao = dataAvaliacao;
  }

  int get erros {
    return _erros;
  }

  set sErros(int erros) {
    _erros = erros;
  }

  int get omissoes {
    return _omissoes;
  }

  set sOmissoes(int omissoes) {
    _omissoes = omissoes;
  }

  int get acertos {
    return _acertos;
  }

  set sAcertos(int acertos) {
    _acertos = acertos;
  }

  int get qtdeCliques {
    return _qtdeCliques;
  }

  set sQtdeCliques(int qtdeCliques) {
    _qtdeCliques = qtdeCliques;
  }

  String get tipo {
    return _tipo;
  }

  set sTipo(String tipo) {
    _tipo = tipo;
  }
}
