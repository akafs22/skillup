import 'package:flutter/material.dart';
import 'package:skillup/Provider/curso/cursoprovider.dart';
import 'package:provider/provider.dart';

class CriaCursoPage extends StatefulWidget {
  const CriaCursoPage({super.key});

  @override
  _CriaCursoPageState createState() => _CriaCursoPageState();
}

class _CriaCursoPageState extends State<CriaCursoPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _orgaoEmissorController = TextEditingController();
  final List<Map<String, String>> _matriculados = [];
  bool _isEditable = false;

  void _onFazerAlteracoes() {
    setState(() {
      _isEditable = true;
    });
  }

  void _onSalvar() {
    setState(() {
      _isEditable = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Treinamento salvo com sucesso!')),
    );
  }

  void _onExcluir() {
    setState(() {
      _nomeController.clear();
      _matriculados.clear();
      _descricaoController.clear();
      _orgaoEmissorController.clear();
      _isEditable = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados excluídos!')),
    );
  }

  void _adicionarMatriculado() {
    if (_isEditable) {
      setState(() {
        _matriculados.add({"nome": "", "matricula": ""});
      });
    }
  }

  void _removerMatriculado(int index) {
    setState(() {
      _matriculados.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6ECBDE),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Criar Curso"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "NOME DO CURSO",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _nomeController,
              enabled: _isEditable,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite o nome do treinamento',
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "COLABORADORES",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            // Contêiner com rolagem para os alunos matriculados
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(
                maxHeight: 150, // Limite de altura para permitir scroll
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("CPF", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(),
                    ..._matriculados.asMap().entries.map((entry) {
                      int index = entry.key;
                      var aluno = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                enabled: _isEditable,
                                decoration: const InputDecoration(
                                  hintText: "Nome",
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  _matriculados[index]["nome"] = value;
                                },
                                controller: TextEditingController(text: aluno["nome"]),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                enabled: _isEditable,
                                decoration: const InputDecoration(
                                  hintText: "CPF",
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  _matriculados[index]["CPF"] = value;
                                },
                                controller: TextEditingController(text: aluno["matricula"]),
                              ),
                            ),
                            if (_isEditable)
                              IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () => _removerMatriculado(index),
                              ),
                          ],
                        ),
                      );
                    }),
                    if (_isEditable)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _adicionarMatriculado,
                          child: const Text("Adicionar aluno"),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "DESCRIÇÃO",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _descricaoController,
              enabled: _isEditable,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Descrição',
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _onFazerAlteracoes,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("FAZER ALTERAÇÕES"),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isEditable ? _onSalvar : null,
                    style: ElevatedButton.styleFrom(

                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("SALVAR"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isEditable ? _onExcluir : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("EXCLUIR"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}