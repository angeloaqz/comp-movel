import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercicio1Page(),
  ));
}

class Exercicio1Page extends StatefulWidget {
  const Exercicio1Page({super.key});

  @override
  State<Exercicio1Page> createState() => _Exercicio1PageState();
}

class _Exercicio1PageState extends State<Exercicio1Page> {
  bool _ativo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercício 1 - AnimatedContainer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: _ativo ? 250 : 120,
              height: _ativo ? 220 : 100,
              color: _ativo ? Colors.deepPurple : Colors.blue,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _ativo = !_ativo;
                });
              },
              child: const Text('Animar Cor e Altura'),
            ),
          ],
        ),
      ),
    );
  }
}
