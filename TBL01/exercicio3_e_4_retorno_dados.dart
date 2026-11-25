import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Tela1(),
  ));
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  int valorAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 1 - Retorno de Valor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valor atual: $valorAtual',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.push<int>(
                  context,
                  MaterialPageRoute(builder: (context) => const Tela2()),
                );

                if (resultado != null) {
                  setState(() {
                    valorAtual = resultado;
                  });
                }
              },
              child: const Text('Escolher Número'),
            ),
          ],
        ),
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final TextEditingController _numeroController = TextEditingController();

  @override
  void dispose() {
    _numeroController.dispose();
    super.dispose();
  }

  void _enviarDigitado() {
    final valor = int.tryParse(_numeroController.text.trim());
    if (valor != null) {
      Navigator.pop(context, valor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 2 - Escolher ou Digitar')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 10),
                  child: const Text('Enviar 10'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 20),
                  child: const Text('Enviar 20'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _numeroController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite um número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _enviarDigitado,
              child: const Text('Enviar Número Digitado'),
            ),
          ],
        ),
      ),
    );
  }
}
