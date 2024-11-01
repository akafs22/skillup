import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:skillup/Provider/usuario/create_user.dart';
import 'package:skillup/Utils/mensage.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool _isChecked = false;
  final maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );


  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Consumer<ValidarSenha>(builder: (context, provider, _) {
          return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              colors: [
                Color(0xff002657),
                Color(0xff002657),
                Color(0xff1B4E79),
                Color(0xff6ecbe0),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'CADASTRE-SE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Nome*', _nomeController, TextInputType.text),
              _buildTextField('CPF*', _cpfController, TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              _buildTextField(
                  'Email*', _emailController, TextInputType.emailAddress),
              _buildTextField('Senha*', _senhaController, TextInputType.text,
                  obscureText: true),
              _buildTextField('Número de telefone*', _telefoneController,
                  TextInputType.phone,
                  inputFormatters: [maskFormatter]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: const Color(0xff1B4E79),
                  ),
                  const Text(
                    'Eu concordo com os Termos de Uso',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              provider.carregando ? const CircularProgressIndicator() :
              ElevatedButton(
                onPressed: () async {
                  if (_isChecked) {
                    await provider.createUser(_nomeController.text, _cpfController.text, _senhaController.text, _emailController.text, _telefoneController.text, _tipoController.text);
                    if (provider.valido) {
                      showMessage(message: provider.msgErrorApi, context: context);
                      Navigator.of(context).pushNamed('/');
                    } else {
                    showMessage(message: provider.msgErrorApi, context: context);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Você deve concordar com os termos de uso.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1B4E79),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'CRIAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
        },)
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      TextInputType keyboardType,
      {bool obscureText = false, List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
        ),
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
      ),
    );
  }
}