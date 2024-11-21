import 'package:flutter/material.dart';

class TelaCursos extends StatelessWidget {
  final String nomeFuncionario;
  final List<dynamic> cursos;

  TelaCursos({required this.nomeFuncionario, required this.cursos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos de $nomeFuncionario'),
      ),
      body: cursos.isEmpty
          ? Center(child: Text('Nenhum curso encontrado para $nomeFuncionario'))
          : ListView.builder(
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                final curso = cursos[index];
                return ListTile(
                  title: Text(curso['nomeCurso']),
                  subtitle: Text('ID do Curso: ${curso['idCurso']}'),
                );
              },
            ),
    );
  }
}
