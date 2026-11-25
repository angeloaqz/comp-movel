import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class LastPageScreen extends StatefulWidget {
  const LastPageScreen({super.key});

  @override
  State<LastPageScreen> createState() => _LastPageScreenState();
}

class _LastPageScreenState extends State<LastPageScreen> {
  final StorageService storage = StorageService();
  String paginaSelecionada = 'Página A';

  @override
  void initState() {
    super.initState();
    _carregarPagina();
  }

  Future<void> _carregarPagina() async {
    final salva = await storage.loadLastPage();
    setState(() {
      paginaSelecionada = salva;
    });
  }

  Future<void> _selecionarPagina(String pagina) async {
    setState(() {
      paginaSelecionada = pagina;
    });
    await storage.saveLastPage(pagina);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Última Ação do Usuário'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _selecionarPagina('Página A'),
                    child: const Text('Página A'),
                  ),
                  ElevatedButton(
                    onPressed: () => _selecionarPagina('Página B'),
                    child: const Text('Página B'),
                  ),
                  ElevatedButton(
                    onPressed: () => _selecionarPagina('Página C'),
                    child: const Text('Página C'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Página selecionada: $paginaSelecionada',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
