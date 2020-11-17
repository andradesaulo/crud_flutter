import 'package:flutter/material.dart';
import 'package:crud_flutter/model/personagem.dart';
import 'package:crud_flutter/db/database_helper.dart';
import 'package:crud_flutter/ui/personagem_screen.dart';

class ListViewPersonagem extends StatefulWidget {
  @override
  _ListViewPersonagemState createState() => _ListViewPersonagemState();
}

class _ListViewPersonagemState extends State<ListViewPersonagem> {
  List<Personagem> items = new List();

  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();
    db.getPersonagens().then((personagens) {
      setState(() {
        personagens.forEach((personagem) {
          items.add(Personagem.fromMap(personagem));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Personagens'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(
                children: [
                  Divider(height: 5.0),
                  ListTile(
                    title: Text(
                      '${items[position].nome}',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '${items[position].apelido} ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          )
                        ),
                        Text(
                          '${items[position].especie} ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          )
                        ),
                        Text(
                          '${items[position].anoCriacao}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontStyle: FontStyle.italic,
                          )
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _deletePersonagem(
                            context, items[position], position
                          )
                        )
                      ]
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 15.0,
                      child: Text(
                        '${items[position].id}',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () => _navigateToPersonagem(
                      context,
                      items[position],
                    )
                  ),
                ]
              );
            }
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewPersonagem(
            context
          ),
        ),
      ),
    );
  }

  void _deletePersonagem(BuildContext context, Personagem personagem, int position) async {
    db.deletePersonagem(personagem.id).then((personagens) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToPersonagem(BuildContext context, Personagem personagem) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonagemScreen(personagem)),
    );
    if (result == 'update') {
      db.getPersonagens().then((personagens) {
        setState(() {
          items.clear();
          personagens.forEach((personagem) {
            items.add(Personagem.fromMap(personagem));
          });
        });
      });
    }
  }

  void _createNewPersonagem(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonagemScreen(Personagem('', '', '', 2020))),
    );
    if (result == 'save') {
      db.getPersonagens().then((personagens) {
        setState(() {
          items.clear();
          personagens.forEach((personagem) {
            items.add(Personagem.fromMap(personagem));
          });
        });
      });
    }
  }
}