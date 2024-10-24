import 'package:flutter/material.dart';

class ListaColab extends StatelessWidget {
  final List<Colaborador> colaboradores = [
    Colaborador(
      nome: "ANNA KLARA DE ALMEIDA F. SILVA",
      matricula: "0198",
      treinamento: "Treinamento de uso de EPI",
      status: "CONCLUÍDO",
      icone: Icons.pan_tool, // Ícone de mão
      corIcone: Colors.black,
      corStatus: Colors.green,
    ),
    Colaborador(
      nome: "LETÍCIA MARTINS GALDINO",
      matricula: "0011",
      treinamento: "Treinamento de uso de aparelhos",
      status: "INTERROMPIDO",
      icone: Icons.access_alarm_rounded,
      corIcone: Colors.blue,
      corStatus: Colors.red,
    ),
    Colaborador(
      nome: "JÚLIA RODRIGUES",
      matricula: "0168",
      treinamento: "Treinamento de uso de EPI",
      status: "INCOMPLETO",
      icone: Icons.pets, // Ícone de gato
      corIcone: Colors.purple,
      corStatus: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Colaboradores'),
        backgroundColor: Colors.cyan[600],
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
                Text('Matrícula Nº ${colaborador.matricula}'),
                Text(colaborador.treinamento),
                Text(
                  'Status: ${colaborador.status}',
                  style: TextStyle(
                    color: colaborador.corStatus,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
  final String matricula;
  final String treinamento;
  final String status;
  final IconData icone;
  final Color corIcone;
  final Color corStatus;

  Colaborador({
    required this.nome,
    required this.matricula,
    required this.treinamento,
    required this.status,
    required this.icone,
    required this.corIcone,
    required this.corStatus,
  });
}
