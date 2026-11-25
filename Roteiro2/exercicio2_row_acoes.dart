import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercicio2Page(),
  ));
}

class Exercicio2Page extends StatelessWidget {
  const Exercicio2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row de Ações'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.home, size: 32),
                SizedBox(height: 4),
                Text('Início'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.search, size: 32),
                SizedBox(height: 4),
                Text('Pesquisar'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.person, size: 32),
                SizedBox(height: 4),
                Text('Perfil'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
