import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillup/Provider/curso/cursoprovider.dart';

class CursoPage extends StatefulWidget {
  const CursoPage({super.key});

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Curso"),
        centerTitle: true,
        backgroundColor: const Color(0xFF6ECBDE),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/CriaCursoPage');
            },
            icon: const Icon(Icons.add),
            tooltip: 'Adicionar novo colaborador', 
          ),
        ],
      ),
      body: 
      
      Consumer<CursoProvider>(builder: (context, provider, _) {
        return ListView.builder(
          itemCount: provider.cursos.length,
          itemBuilder:  (context, index) {
              final curso = provider.cursos[index];
            return const ListTile(
              title: curso.nome,
              subtitle: curso.descricao,
            );
          }, 
          );
      },)
      
      
    );
  }

  void _onCriarCurso(BuildContext context) {
    Navigator.pushNamed(context, '/CriaCursoPage');
  }
}