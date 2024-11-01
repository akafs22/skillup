import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillup/Provider/login/logar.dart';
import 'package:skillup/Utils/drawer.dart';

class MainColaborador extends StatefulWidget {
  const MainColaborador({super.key});

  @override
  State<MainColaborador> createState() => _MainColaboradorState();
}

class _MainColaboradorState extends State<MainColaborador>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _cursos = ['Julia', 'Leticia', 'Ana', 'Júlia'];
  List<String> _filteredCursos = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredCursos = List.from(_cursos);

    _searchController.addListener(() {
      setState(() {
        _filteredCursos = _cursos
            .where((curso) => curso
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Consumer<Logar>(builder: (context, provider, child) {

      return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 110, 203, 224),
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isLargeScreen
                    ? _buildUserAccountInfo()
                    : IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Buscar curso',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                    ),
                  ),
                ),
                Image.asset('images/logop.png'),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildColaboradorList(),
                const Center(child: Text('Lista de Cursos')),
              ],
            ),
          ),
        ],
      ),
      drawer: colabdrawer(context, provider.dadosUer["nome"], provider.dadosUer["email"]),
    );
      
    },  
    );
  }

  Widget _buildUserAccountInfo() {
    return Consumer<Logar>(
      builder: (context, provider, _) {
        return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Color.fromRGBO(50, 64, 82, 1)),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             provider.dadosUer["nome"] ?? "nome não carregado!",
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
               provider.dadosUer["email"] ?? "nome não carregado!",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ],
    );
      },
    );
  }

  Widget _buildColaboradorList() {
    return ListView.builder(
      itemCount: _filteredCursos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_filteredCursos[index]),
        );
      },
    );
  }

}
