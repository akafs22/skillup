import 'package:flutter/material.dart';
import 'package:skillup/Services/salvaroffline.dart';
import 'package:skillup/pages/offline/tela_funcionarios.dart';

Widget? meudrawer(BuildContext contexto, String nome, String email) {
    final UsuarioService usuarioService = UsuarioService();
    return Drawer(
        backgroundColor: const Color.fromRGBO(50, 64, 82, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color.fromRGBO(50, 64, 82, 1)),
              ),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(50, 64, 82, 1),
              ),
              accountName: Text( nome ?? "Não carregado", style: const TextStyle(color: Colors.white)),
              accountEmail:
                  Text(email ?? "Não carregado", style: const TextStyle(color: Colors.white70)),
            ),
            ListTile(
              title: const Text('Lista de colaboradores',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(contexto).pushNamed("/ListaColab");
              },
            ),
            ListTile(
              title: const Text('Lista de cursos',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(contexto).pushNamed("/CursoPage");
              },
            ),
             ListTile(
              title: const Text('Cadastro de orgão emissor',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(contexto).pushNamed("/OrgaoEmissor");
              },
            ),
            ElevatedButton(
          onPressed: () async {
            try {
              await usuarioService.salvarUsuariosComCursos();
              ScaffoldMessenger.of(contexto).showSnackBar(
                const SnackBar(content: Text('Dados carregados e salvos com sucesso!')),
              );
              Navigator.push(
                contexto,
                MaterialPageRoute(builder: (context) => const TelaFuncionarios()),
              );
            } catch (e) {
              print(e);
              ScaffoldMessenger.of(contexto).showSnackBar(
                SnackBar(content: Text('Erro ao carregar os dados: $e')),
              );
            }
          },
          child: const Text('Carregar Dados'),
        ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Sair',
                  style: TextStyle(color: Color.fromARGB(255, 224, 66, 66))),
              onTap: () {
                Navigator.of(contexto).pushNamed("/");
              },
            ),
          ],
        ),
      );
}

Widget? colabdrawer(BuildContext contexto, String nome, String email) {
    return Drawer(
        backgroundColor: const Color.fromRGBO(50, 64, 82, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color.fromRGBO(50, 64, 82, 1)),
              ),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(50, 64, 82, 1),
              ),
              accountName: Text( nome ?? "Não carregado", style: const TextStyle(color: Colors.white)),
              accountEmail:
                  Text(email ?? "Não carregado", style: const TextStyle(color: Colors.white70)),
            ),
          ]
        ),
      );
}