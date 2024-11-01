import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillup/Model/orgaoEmissor.dart';
import 'package:skillup/Provider/curso/orgaoEmissorprovider.dart';
import 'package:skillup/Utils/drawer.dart';

class OrgaoemissorCad extends StatefulWidget {
  const OrgaoemissorCad({super.key});

  @override
  State<OrgaoemissorCad> createState() => _OrgaoemissorcadState();
}

class _OrgaoemissorcadState extends State<OrgaoemissorCad> {
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _nomecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Órgão Emissor'),
        backgroundColor: Colors.cyan[600],
      ),
      body: Consumer<OrgaoEmissorProvider>(builder: (context, provider, _) {
        return provider.carregando
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    const SizedBox(height: 30),
                    const Text(
                      'Cadastro de Órgão Emissor',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: TextField(
                        controller: _idcontroller,
                        decoration: InputDecoration(
                          labelText: 'Insira o Id',
                          labelStyle: const TextStyle(color: Colors.cyan),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.cyan),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.cyan),
                          ),
                          filled: true,
                          fillColor: Colors.cyan.withOpacity(0.1),
                        ),
                        style: const TextStyle(color: Colors.cyan),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: TextField(
                        controller: _nomecontroller,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: const TextStyle(color: Colors.cyan),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.cyan),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.cyan),
                          ),
                          filled: true,
                          fillColor: Colors.cyan.withOpacity(0.1),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.cyan,
                            ),
                            onPressed: () async {
                              final orgaoEmissor = OrgaoEmissor(
                                id: int.parse(_idcontroller.text),
                                nome: _nomecontroller.text,
                              );
                              await provider.cadastrarOrgaoEmissor(orgaoEmissor);
                              if (provider.cadastrado) {
                                Navigator.of(context).pushNamed("/Treinamento");
                              }
                            },
                          ),
                        ),
                        style: const TextStyle(color: Colors.cyan),
                      ),
                    ),
                  ],
                ),
              );
      }),
      );
  }
}