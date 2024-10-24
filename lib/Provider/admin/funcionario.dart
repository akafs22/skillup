import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillup/Constrain/url.dart';
import 'package:skillup/Utils/mensage.dart';

class CadastroProvider with ChangeNotifier {
  bool _isChecked = false;
  bool _isLoading = false;

  bool get isChecked => _isChecked;
  bool get isLoading => _isLoading;

  final maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: { "#": RegExp(r'[0-9]') },
  );

  void toggleChecked() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  Future<void> cadastrar(
    BuildContext context,
    String nome,
    String cpf,
    String email,
    String senha,
    String telefone,
  ) async {
    var dados = await SharedPreferences.getInstance();
    String? token = dados.getString("token");
    
    String url = '${AppUrl.baseUrl}api/Usuario';

    _isLoading = true;
    notifyListeners();

    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    int cpfParse = int.parse(cpf);

    Map<String, dynamic> requestBody = {
      "nome": nome,
      "cpf": cpfParse,
      "email": email,
      "senha": senha,
      "telefone": telefone
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );

    _isLoading = false;
    notifyListeners();

     if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("certo");
      showMessage(
          message: 'Colaborador cadastrado com sucesso!',
          // ignore: use_build_context_synchronously
          context: context);
    } else {
      debugPrint(response.body);
      showMessage(
          message: 'Erro ao cadastrar colaborador!',
          // ignore: use_build_context_synchronously
          context: context);
    }
  }
}
