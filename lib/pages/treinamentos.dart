import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillup/Provider/curso/cursoprovider.dart';
import 'package:skillup/Utils/mensage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<CursoProvider>(context, listen: false).listarCursos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treinamentos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TreinamentoPage(),
    );
  }
}

class TreinamentoPage extends StatefulWidget {
  const TreinamentoPage({super.key});

  @override
  State<TreinamentoPage> createState() => _TreinamentoPageState();
}

class _TreinamentoPageState extends State<TreinamentoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<CursoProvider>(builder: (context, provider, child) {
        if (provider.cursos.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: provider.cursos.length,
            itemBuilder: (context, index) {
              final curso = provider.cursos[index];
              return ListTile(
                  title: Text(curso.nome),
                  subtitle: Text(curso.descricao),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                 builder: (context) => CadastrarSalas(
                            //                     ambiente: ambiente),
                            //               ),
                            //             );
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            // Exibe a confirmação antes de excluir
                            bool? confirm = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirmar Exclusão'),
                                content: Text(
                                    'Tem certeza de que deseja excluir a sala: ${curso.nome}?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Confirmar'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await provider.deletarCurso(curso.id);
                              showMessage(
                                  message: provider.menssagem,
                                  context: context);
                            }
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ));
            });
      }),
    );
  }

  Widget _buildUserAccountInfo() {
    return const Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Color.fromRGBO(50, 64, 82, 1)),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Julia",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "Administrador",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }
}
