
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillup/Constrain/url.dart';
import 'package:http/http.dart' as http;
import 'package:skillup/Model/curso.dart';

class CursoProvider with ChangeNotifier{
  
  bool _cadastrado = false;
  bool get cadastrado => _cadastrado;

  bool _carregando = false;
  bool get carregando => _carregando;

  String _menssagem = "";
  String get menssagem => _menssagem;

  List<Curso> _cursos = [];

  List<Curso> get cursos => _cursos;

  String? token;

//pegar token
  Future<void> pegarToken() async {
    var dados = await SharedPreferences.getInstance();
    token = dados.getString("token");
  }


//cadastrar
Future<void> cadastrarCurso(Curso curso) async {
     final url = '${AppUrl.baseUrl}api/Curso';
    
    try {
      await pegarToken();
      final response = await http.post(
        Uri.parse(url),
        headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
        body: json.encode(curso.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
         _cadastrado = true;
         _carregando = false;
         _menssagem = "Curso Cadastrado com sucesso!";
        notifyListeners();
      } else {
          _cadastrado = false;
         _carregando = false;
         _menssagem = "Erro ao cadastrar curso!";
         notifyListeners();
      }
    } catch (error) {
        _cadastrado = false;
         _carregando = false;
         _menssagem = "Dados Incorretos ou erro de servidor$error";
         notifyListeners();
    }
  }


//listar
  Future<void> listarCursos() async {
      final url = '${AppUrl.baseUrl}api/Cursos';
    try {
      await pegarToken();
      final response = await http.get(Uri.parse(url),
       headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _cursos = data.map((json) => Curso.fromJson(json)).toList();
        _carregando = false;
        notifyListeners();
      } else {
        _carregando = false;
         notifyListeners();
      }
    } catch (error) {
        _cadastrado = false;
         _carregando = false;
         _menssagem = "Erro ao carregar dos do servidor";
         notifyListeners();
    }
  }


    // Método para atualizar 
  Future<void> atualizarCurso(Curso curso)async {
    try {
      final response = await http.put(
        Uri.parse('${AppUrl.baseUrl}api/Cursos${curso.id}'),
         headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },

        body: jsonEncode(curso.toJson()),
      );
      
      if (response.statusCode == 200 || response.statusCode == 204) {
        _menssagem = 'Curso atualizado com sucesso!';
        listarCursos();
        notifyListeners();
      } else {
        _menssagem = 'Erro ao atualizar curso!';
        notifyListeners();
      }
    } catch (error) {
      _menssagem = 'Ocorreu algum erro no servidor!';
      notifyListeners();
    }
  }

  // Função para deletar 
  Future<void> deletarCurso(int id) async {
    final url = Uri.parse('${AppUrl.baseUrl}api/Cursos/$id');

    try {
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200 || response.statusCode == 204) {
         _menssagem = 'Curso Deletado com com Sucesso';
       listarCursos(); 
        notifyListeners();
      } else {
         _menssagem = 'Erro ao deletar Curso';
        notifyListeners();
      }
    } catch (error) {
      _menssagem = 'Erro de conexão como servidor!';
      notifyListeners();
    }
  }

}