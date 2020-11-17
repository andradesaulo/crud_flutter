import 'package:flutter/material.dart';
import 'package:crud_flutter/model/personagem.dart';
import 'package:crud_flutter/db/database_helper.dart';

class PersonagemScreen extends StatefulWidget {
  final Personagem personagem;
  PersonagemScreen(this.personagem);
  @override
  State<StatefulWidget> createState() => _PersonagemScreenState();
}

class _PersonagemScreenState extends State<PersonagemScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _apelidoController;
  TextEditingController _especieController;
  TextEditingController _anoCriacaoController;
  @override
  void initState() {
    super.initState();
    _nomeController =
        TextEditingController(text: widget.personagem.nome);
    _apelidoController =
        TextEditingController(text: widget.personagem.apelido);
    _especieController =
        TextEditingController(text: widget.personagem.especie);
    _anoCriacaoController =
        TextEditingController(text: widget.personagem.anoCriacao.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personagem')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child:Column(
          children: [
            Image(
              image: NetworkImage('https://i.pinimg.com/originals/f6/6b/f1/f66bf11afe640d3eb545493a85f19d51.jpg')
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText:'Nome'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _apelidoController,
              decoration: InputDecoration(labelText:'Apelido'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _especieController,
              decoration: InputDecoration(labelText:'Espécie'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              keyboardType: TextInputType.number,
              controller: _anoCriacaoController,
              decoration: InputDecoration(labelText:'Ano de criação'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            RaisedButton(
              child:
                (widget.personagem.id != null) ? Text('Alterar') : Text('Inserir'),
              onPressed: () {
                if (widget.personagem.id != null) {
                  db.updatePersonagem(Personagem.fromMap({
                    'id': widget.personagem.id,
                    'nome': _nomeController.text,
                    'apelido': _apelidoController.text,
                    'especie': _especieController.text,
                    'anoCriacao': int.parse(_anoCriacaoController.text),
                  })).then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db.inserirPersonagem(Personagem(_nomeController.text, _apelidoController.text, _especieController.text, int.parse(_anoCriacaoController.text)))
                      .then((_) {
                        Navigator.pop(context, 'save');
                  });
                }
              },
            )
          ],
        )
      )
    );
  }
}