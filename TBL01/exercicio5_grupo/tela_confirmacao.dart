import 'package:flutter/material.dart';

class TelaConfirmacao extends StatelessWidget {
  final String nome;
  final int idade;

  const TelaConfirmacao({
    super.key,
    required this.nome,
    required this.idade,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela de Confirmação')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Confirmar cadastro de $nome, $idade anos?',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cadastro confirmado: $nome ($idade anos)');
                    },
                    child: const Text('Confirmar'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Voltar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
