import 'package:flutter/material.dart';

Widget meudrawer(BuildContext contexto) => Drawer(
      backgroundColor: const Color.fromRGBO(50, 64, 82, 1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color.fromRGBO(50, 64, 82, 1)),
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(50, 64, 82, 1),
            ),
            accountName: Text("Julia", style: TextStyle(color: Colors.white)),
            accountEmail:
                Text("Administrador", style: TextStyle(color: Colors.white70)),
          ),
          ListTile(
            title: const Text('Lista de colaboradores',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(contexto).pushNamed("/ListaColab");
            },
          ),
          ListTile(
            title: const Text('Lista de treinamentos',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(contexto).pushNamed("/Treinamento");
            },
          ),
          const SizedBox(height: 450),
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