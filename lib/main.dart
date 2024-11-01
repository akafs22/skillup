import 'package:flutter/material.dart';
import 'package:skillup/Provider/admin/cadcurso.dart';
import 'package:skillup/Provider/admin/funccurso.dart';
import 'package:skillup/Provider/admin/funcionario.dart';
import 'package:skillup/Provider/curso/cursoprovider.dart';
import 'package:skillup/Provider/curso/orgaoEmissorprovider.dart';
import 'package:skillup/Provider/login/logar.dart';
import 'package:skillup/Provider/usuario/create_user.dart';
import 'package:skillup/Provider/usuario/verifica_usuario.dart';
import 'package:skillup/pages/Admin/cadastro.dart';
import 'package:skillup/pages/Admin/criaTreina.dart';
import 'package:skillup/pages/Admin/orgaoEmissorCad.dart';
import 'package:skillup/pages/curso.dart';
import 'package:skillup/pages/Admin/listaColab.dart';
import 'package:skillup/pages/Admin/login.dart';
import 'package:skillup/pages/Admin/mainAdmin.dart';
import 'package:skillup/pages/Admin/perf_adm.dart';
import 'package:skillup/pages/Admin/treinamentos.dart';
import 'package:provider/provider.dart';
import 'package:skillup/pages/mainColaborador.dart';

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
        ChangeNotifierProvider(create: (_) => OrgaoEmissorProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const Login(),
          "/EditAdm": (context) => const EditAdm(),
          "/Cadastro": (context) => const Cadastro(),
          "/MainAdmin": (context) => const MainAdmin(),
          "/Curso": (context) => const Treinamento(),
          "/Treinamento": (context) => const TreinamentoPage(),
          "/CriaTreinamento": (context) => const CriaTreinamento(),
          "/ListaColab": (context) => ListaColab(),
          "/MainColaborador": (context) => const MainColaborador(),
          "/OrgaoEmissorCad": (context) => const OrgaoemissorCad()
        },
      )));
}
