import 'package:flutter/material.dart';

class ListaColab extends StatefulWidget {
  @override
  State<ListaColab> createState() => _ListaColabState();
}

class _ListaColabState extends State<ListaColab> {
  final List<Colaborador> colaboradores = [
    Colaborador(
      nome: "ANNA KLARA DE ALMEIDA F. SILVA",
      cpf: "0198",
      icone: Icons.pan_tool,
      corIcone: Colors.black,
    ),
    Colaborador(
      nome: "LETÍCIA MARTINS GALDINO",
      cpf: "0011",
      icone: Icons.access_alarm_rounded,
      corIcone: Colors.blue,
    ),
    Colaborador(
      nome: "JÚLIA RODRIGUES",
      cpf: "0168",
      icone: Icons.pets,
      corIcone: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Colaboradores'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/Cadastro');
            },
            icon: Icon(Icons.add),
            tooltip: 'Adicionar novo colaborador', 
          ),
        ],
        backgroundColor: Color.fromARGB(255, 110, 203, 224),
      ),
      body: ListView.builder(
        itemCount: colaboradores.length,
        itemBuilder: (context, index) {
          final colaborador = colaboradores[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: colaborador.corIcone,
              child: Icon(
                colaborador.icone,
                color: Colors.white,
              ),
            ),
            title: Text(
              colaborador.nome,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${colaborador.cpf}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Colaborador {
  final String nome;
  final String cpf;
  final IconData icone;
  final Color corIcone;

  Colaborador({
    required this.nome,
    required this.cpf,
    required this.icone,
    required this.corIcone,
  });
}