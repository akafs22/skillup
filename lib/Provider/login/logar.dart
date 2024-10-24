import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skillup/Constrain/url.dart';
import 'package:skillup/Data/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logar extends ChangeNotifier {
  bool _valido = false;
  bool _logado = false;
  String _msgError = '';
  bool _carregando = false;
  String _rota = "";

  bool get ehvalido => _valido;
  bool get logado => _logado;
  String get msgError => _msgError;
  bool get carregando => _carregando;
  String get rota => _rota;

  void validatePassword(String password) {
    _msgError = '';
    if (password.length < 8) {
      _msgError = 'Mínimo 8 dígitos';
    } else if (!password.contains(RegExp(r'[a-z]'))) {
      _msgError = 'Pelo menos uma letra minúscula';
    } else if (!password.contains(RegExp(r'[A-Z]'))) {
      _msgError = 'Pelo menos uma letra maiúscula';
    } else if (!password
        .contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{};:\|,.<>\/?]'))) {
      _msgError = 'Pelo menos um carácter especial';
    } else if (!password.contains(RegExp(r'[0-9]'))) {
      _msgError = 'Pelo menos um número';
    }
    _valido = _msgError.isEmpty;
    notifyListeners();
  }

//Logar usuário
  Future logarUsuario(String email, String password, int cpf) async {
    
    _carregando = true;
    notifyListeners();

    String url = '${AppUrl.baseUrl}curso/Usuario/Login';

    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
      'cpf': cpf,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    _carregando = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map dados = jsonDecode(response.body);

      // gravar id
      SharedPreferences idUser = await SharedPreferences.getInstance();
      var ds = GetId(idUser);
      await ds.gravarId(dados['funcId']);
      await ds.gravarToken(dados['token']);
      await ds.gravarNivel(dados['roles'][0]);

      if (dados['roles'][0] == "Basic") {
        _rota = "/dashboard";
      } else {
        _rota = "/admin";
      }
      _logado = true;
      notifyListeners();
    } else if (response.statusCode == 400) {
      _logado = false;
      notifyListeners();
    }
  }
}