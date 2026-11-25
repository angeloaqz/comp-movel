import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercicio2Page(),
  ));
}

class Exercicio2Page extends StatefulWidget {
  const Exercicio2Page({super.key});

  @override
  State<Exercicio2Page> createState() => _Exercicio2PageState();
}

class _Exercicio2PageState extends State<Exercicio2Page> {
  bool _aumentado = false;

  void _animarIcone() async {
    if (_aumentado) return;
    setState(() {
      _aumentado = true;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      setState(() {
        _aumentado = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 2 - Ícone Animado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: _aumentado ? 160 : 80,
              height: _aumentado ? 160 : 80,
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                shape: BoxShape.circle,
              ),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _animarIcone,
              child: const Text('Pulsar Ícone'),
            ),
          ],
        ),
      ),
    );
  }
}
