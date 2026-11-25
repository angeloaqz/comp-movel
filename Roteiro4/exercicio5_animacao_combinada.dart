import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercicio5Page(),
  ));
}

class Exercicio5Page extends StatefulWidget {
  const Exercicio5Page({super.key});

  @override
  State<Exercicio5Page> createState() => _Exercicio5PageState();
}

class _Exercicio5PageState extends State<Exercicio5Page> {
  bool _animado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 5 - Animação Combinada'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              width: _animado ? 280 : 140,
              height: _animado ? 200 : 100,
              decoration: BoxDecoration(
                color: _animado ? Colors.indigo : Colors.amber,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: AnimatedOpacity(
                  opacity: _animado ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 700),
                  child: const Text(
                    'Conteúdo Revelado!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _animado = !_animado;
                });
              },
              child: const Text('Ativar Animação'),
            ),
          ],
        ),
      ),
    );
  }
}
