import 'package:flutter/material.dart';
import 'package:skillup/Provider/admin/cadcurso.dart';
import 'package:skillup/Provider/admin/funccurso.dart';
import 'package:skillup/Provider/admin/funcionario.dart';
import 'package:skillup/Provider/curso/cursoprovider.dart';
import 'package:skillup/Provider/login/logar.dart';
import 'package:skillup/Provider/usuario/create_user.dart';
import 'package:skillup/Provider/usuario/verifica_usuario.dart';
import 'package:skillup/pages/cadastro.dart';
import 'package:skillup/pages/criaTreina.dart';
import 'package:skillup/pages/curso.dart';
import 'package:skillup/pages/listaColab.dart';
import 'package:skillup/pages/login.dart';
import 'package:skillup/pages/mainColab.dart';
import 'package:skillup/pages/perf_adm.dart';
import 'package:skillup/pages/treinamentos.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ValidarSenha()),
        ChangeNotifierProvider(create: (_) => UsuarioCadastrado()),
        ChangeNotifierProvider(create: (_) => Logar()),
        ChangeNotifierProvider(create: (_) => CadCursoProvider()),
        ChangeNotifierProvider(create: (_) => FuncionarioCursoProvider()),
        ChangeNotifierProvider(create: (_) => CursoProvider()),
        ChangeNotifierProvider(create: (_) => FuncionarioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const Login(),
          "/EditAdm": (context) => const EditAdm(),
          "/Cadastro": (context) => const Cadastro(),
          "/MainColab": (context) => const MainColab(),
          "/Curso": (context) => const Treinamento(),
          "/Treinamento": (context) => const TreinamentoPage(),
          "/CriaTreinamento": (context) => const CriaTreinamento(),
          "/ListaColab": (context) => ListaColab(),
        },
      )));
}
