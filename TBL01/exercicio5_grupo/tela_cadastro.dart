import 'package:flutter/material.dart';
import 'tela_confirmacao.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  Future<void> _avancar() async {
    final nome = _nomeController.text.trim();
    final idade = int.tryParse(_idadeController.text.trim());

    if (nome.isEmpty || idade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha nome e idade válidos.')),
      );
      return;
    }

    final confirmado = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => TelaConfirmacao(nome: nome, idade: idade),
      ),
    );

    if (confirmado != null && mounted) {
      Navigator.pop(context, confirmado);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela de Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _avancar,
              child: const Text('Avançar'),
            ),
          ],
        ),
      ),
    );
  }
}
