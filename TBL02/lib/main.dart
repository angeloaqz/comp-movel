import 'package:flutter/material.dart';
import 'screens/mensagem_lifecycle_screen.dart';
import 'screens/pokemon_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPrincipalScreen(),
    );
  }
}

class MenuPrincipalScreen extends StatelessWidget {
  const MenuPrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo de Vida e Consumo de API'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 280,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MensagemLifecycleScreen(),
                      ),
                    );
                  },
                  child: const Text('Atividade 1 - Ciclo de Vida'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 280,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PokemonScreen(),
                      ),
                    );
                  },
                  child: const Text('Atividade 2 - Pokédex API'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
