import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercicio4Page(),
  ));
}

class Exercicio4Page extends StatelessWidget {
  const Exercicio4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colunas Proporcionais'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 160,
                padding: const EdgeInsets.all(12),
                color: Colors.blue.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Notebook Gamer',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('16GB RAM, SSD 512GB, Tela 144Hz'),
                    SizedBox(height: 8),
                    Text('R\$ 4.500,00', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                height: 160,
                color: Colors.grey.shade300,
                child: const Center(
                  child: Icon(Icons.laptop_mac, size: 60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
