import 'package:flutter/material.dart';
import 'screens/task_screen.dart';
import 'screens/last_page_screen.dart';
import 'screens/autosave_form_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPersistenciaScreen(),
    );
  }
}

class MenuPersistenciaScreen extends StatelessWidget {
  const MenuPersistenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roteiro 5 - Persistência'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TaskScreen()),
                    );
                  },
                  child: const Text('Ex 1 e 2 - Lista de Tarefas'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LastPageScreen()),
                    );
                  },
                  child: const Text('Ex 3 - Última Página Acessada'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AutosaveFormScreen()),
                    );
                  },
                  child: const Text('Ex 4 - Formulário Auto-Save'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    );
                  },
                  child: const Text('Ex 5 - Carrinho Persistente'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
