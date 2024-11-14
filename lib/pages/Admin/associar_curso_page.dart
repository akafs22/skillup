import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillup/Provider/curso/cursoprovider.dart';
import 'package:intl/intl.dart';
import 'package:skillup/Utils/mensage.dart';

class AssociarCursoPage extends StatefulWidget {
  final String funcionarioId;
  final String funcionarioNome;

  const AssociarCursoPage({
    super.key,
    required this.funcionarioId,
    required this.funcionarioNome,
  });

  @override
  State<AssociarCursoPage> createState() => _AssociarCursoPageState();
}

class _AssociarCursoPageState extends State<AssociarCursoPage> {
  DateTime? _dataValidade;

  @override
  void initState() {
    super.initState();
    final cursoProvider = Provider.of<CursoProvider>(context, listen: false);
    cursoProvider.listarCursos(); // Carrega todos os cursos
    cursoProvider.listarCursosFuncionario(widget.funcionarioId); // Carrega cursos já associados
  }

  @override
  Widget build(BuildContext context) {
    final cursoProvider = Provider.of<CursoProvider>(context);
    final cursosAssociadosIds = cursoProvider.cursosAssociados.map((curso) => curso.idCurso).toSet();

    return Scaffold(
      appBar: AppBar(
        title: Text('Associar Curso a ${widget.funcionarioNome}'),
        centerTitle: true,
        backgroundColor: const Color(0xFF6ECBDE),
      ),
      body: Column(
        children: [
          Expanded(
            child: cursoProvider.carregando
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: cursoProvider.cursos.length,
                    itemBuilder: (context, index) {
                      final curso = cursoProvider.cursos[index];
                      final isAssociado = cursosAssociadosIds.contains(curso.cursoId);

                      return ListTile(
                        title: Text(curso.nome),
                        trailing: isAssociado
                            ? const Text("Já associado", style: TextStyle(color: Colors.grey))
                            : ElevatedButton(
                                onPressed: () async {
                                  if (_dataValidade != null) {
                                    await cursoProvider.associarFuncionarioCurso(
                                      widget.funcionarioId,
                                      curso.cursoId,
                                      _dataValidade!,
                                    );
                                    showMessage(message: cursoProvider.menssagem, context: context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Selecione uma data de validade')),
                                    );
                                  }
                                },
                                child: const Text("Associar"),
                              ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Data de Validade"),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _dataValidade = selectedDate;
                      });
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: _dataValidade != null ? DateFormat('yyyy-MM-dd').format(_dataValidade!) : '',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
