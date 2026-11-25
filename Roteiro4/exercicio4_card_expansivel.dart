import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercicio4Page(),
  ));
}

class Exercicio4Page extends StatefulWidget {
  const Exercicio4Page({super.key});

  @override
  State<Exercicio4Page> createState() => _Exercicio4PageState();
}

class _Exercicio4PageState extends State<Exercicio4Page> {
  bool _expandido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 4 - Card Expansível'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _expandido = !_expandido;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOut,
            width: _expandido ? 300 : 180,
            height: _expandido ? 220 : 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _expandido ? Colors.teal : Colors.teal.shade300,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Card Interativo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _expandido
                      ? 'Detalhes expandidos! Clique novamente para recolher.'
                      : 'Toque para expandir',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
