import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillup/Provider/login/logar.dart';
import 'package:skillup/Utils/drawer.dart';

class MainAdmin extends StatefulWidget {
  const MainAdmin({super.key});

  @override
  State<MainAdmin> createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _colaboradores = ['Julia', 'Leticia', 'Ana', 'Júlia'];
  List<String> _filteredColaboradores = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredColaboradores = List.from(_colaboradores);

    _searchController.addListener(() {
      setState(() {
        _filteredColaboradores = _colaboradores
            .where((colaborador) => colaborador
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
                        hintText: 'Buscar colaborador',
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
            child: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                color: Color(0xFF2282FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Colaboradores'),
                Tab(text: 'Administrador'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildColaboradorList(),
                const Center(child: Text('Lista de Administradores')),
              ],
            ),
          ),
        ],
      ),
      drawer: meudrawer(context, provider.dadosUer["nome"], provider.dadosUer["email"]),
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
      itemCount: _filteredColaboradores.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_filteredColaboradores[index]),
        );
      },
    );
  }

}