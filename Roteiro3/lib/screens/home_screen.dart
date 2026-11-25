import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/title_text.dart';
import 'detail_screen.dart';
import 'product_screen.dart';
import 'profile_screen.dart';
import 'task_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleText(texto: 'Menu Principal'),
              const SizedBox(height: 24),
              CustomButton(
                texto: 'Ir para Detalhe',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomButton(
                texto: 'Ir para Produtos',
                cor: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomButton(
                texto: 'Ir para Perfil',
                cor: Colors.orange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomButton(
                texto: 'Lista de Tarefas',
                cor: Colors.purple,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TaskListScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
