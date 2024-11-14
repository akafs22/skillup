import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillup/Model/curso.dart';
import 'package:skillup/Provider/curso/cursoprovider.dart';
import 'package:skillup/Provider/curso/orgaoEmissorProvider.dart';
import 'package:skillup/Utils/mensage.dart';

class CriaCursoPage extends StatefulWidget {
  final Curso? curso;
  const CriaCursoPage({super.key, this.curso});

  @override
  _CriaCursoPageState createState() => _CriaCursoPageState();
}

class _CriaCursoPageState extends State<CriaCursoPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  int? _cursoSelecionado;

  @override
  void initState() {
    super.initState();
    if (widget.curso != null) {
      _nomeController.text = widget.curso!.nome;
      _descricaoController.text = widget.curso!.descricao;
      _cursoSelecionado = widget.curso!.orgaoEmissorId;
    }
    // Carrega os órgãos emissores
    Provider.of<OrgaoEmissorProvider>(context, listen: false).listarOrgaoEmissors();
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
      body: SingleChildScrollView(
        child: Padding(
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite o nome do treinamento',
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
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Descrição',
                ),
              ),
              const SizedBox(height: 20),
              Consumer<OrgaoEmissorProvider>(
                builder: (context, provider, child) {
                  if (provider.orgaoEmissores.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return DropdownButton<int>(
                    isExpanded: true,
                    value: _cursoSelecionado,
                    hint: const Text("Selecione um Órgão Emissor"),
                    items: provider.orgaoEmissores.map((orgao) {
                      return DropdownMenuItem<int>(
                        value: orgao.orgaoEmissorId,
                        child: Text(orgao.nome),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _cursoSelecionado = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer<CursoProvider>(
                builder: (context, provider, _) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_nomeController.text.isEmpty || _descricaoController.text.isEmpty || _cursoSelecionado == null) {
                        showMessage(
                          message: 'Por favor, preencha todos os campos.',
                          context: context,
                        );
                        return;
                      }

                      final cursocad = Curso(
                        cursoId: widget.curso?.cursoId ?? 0,
                        nome: _nomeController.text,
                        descricao: _descricaoController.text,
                        orgaoEmissorId: _cursoSelecionado!,
                      );

                      if (widget.curso == null) {
                        await provider.cadastrarCurso(cursocad);
                      } else {
                        await provider.atualizarCurso(cursocad);
                      }

                      showMessage(
                        message: provider.menssagem,
                        context: context,
                      );

                      // Volta para a tela anterior após salvar
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("SALVAR"),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}