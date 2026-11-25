import 'package:flutter/material.dart';

class MensagemLifecycleScreen extends StatefulWidget {
  const MensagemLifecycleScreen({super.key});

  @override
  State<MensagemLifecycleScreen> createState() => _MensagemLifecycleScreenState();
}

class _MensagemLifecycleScreenState extends State<MensagemLifecycleScreen> {
  bool mensagemVisivel = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('Tela iniciada');
  }

  @override
  void dispose() {
    _controller.dispose();
    print('Tela finalizada');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Tela reconstruída');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo de Vida - Mensagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite uma mensagem',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (mensagemVisivel)
              Text(
                _controller.text.isEmpty
                    ? 'Mensagem visível na tela!'
                    : _controller.text,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  mensagemVisivel = !mensagemVisivel;
                });
              },
              child: Text(mensagemVisivel ? 'Esconder Mensagem' : 'Mostrar Mensagem'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar tela'),
            ),
          ],
        ),
      ),
    );
  }
}
