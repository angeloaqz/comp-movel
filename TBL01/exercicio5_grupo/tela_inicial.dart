import 'package:flutter/material.dart';
import 'tela_cadastro.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String statusCadastro = 'Nenhum cadastro confirmado ainda.';

  Future<void> _iniciarFluxo() async {
    final resultado = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastro()),
    );

    if (resultado != null) {
      setState(() {
        statusCadastro = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Inicial')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                statusCadastro,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _iniciarFluxo,
                child: const Text('Iniciar Cadastro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
