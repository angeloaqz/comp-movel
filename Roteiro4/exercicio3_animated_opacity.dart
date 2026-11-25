import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercicio3Page(),
  ));
}

class Exercicio3Page extends StatefulWidget {
  const Exercicio3Page({super.key});

  @override
  State<Exercicio3Page> createState() => _Exercicio3PageState();
}

class _Exercicio3PageState extends State<Exercicio3Page> {
  bool _visivel = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 3 - AnimatedOpacity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _visivel ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: const Text(
                'Texto com Opacidade Animada!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _visivel = !_visivel;
                });
              },
              child: Text(_visivel ? 'Esconder Texto' : 'Mostrar Texto'),
            ),
          ],
        ),
      ),
    );
  }
}
