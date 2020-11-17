class Personagem {
  int _id;
  String _nome;
  String _apelido;
  String _especie;
  int _anoCriacao;

  Personagem(this._nome, this._apelido, this._especie, this._anoCriacao);

  Personagem.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._apelido = obj['apelido'];
    this._especie = obj['especie'];
    this._anoCriacao = obj['anoCriacao'];
  }

  int get id => _id;
  String get nome => _nome;
  String get apelido => _apelido;
  String get especie => _especie;
  int get anoCriacao => _anoCriacao;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['apelido'] = _apelido;
    map['especie'] = _especie;
    map['anoCriacao'] = _anoCriacao;
    return map;
  }

  Personagem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._apelido = map['apelido'];
    this._especie = map['especie'];
    this._anoCriacao = map['anoCriacao'];
  }
}