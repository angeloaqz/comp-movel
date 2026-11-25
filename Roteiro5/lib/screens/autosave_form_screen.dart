import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class AutosaveFormScreen extends StatefulWidget {
  const AutosaveFormScreen({super.key});

  @override
  State<AutosaveFormScreen> createState() => _AutosaveFormScreenState();
}

class _AutosaveFormScreenState extends State<AutosaveFormScreen> {
  final StorageService storage = StorageService();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarFormulario();
  }

  Future<void> _carregarFormulario() async {
    final dados = await storage.loadForm();
    setState(() {
      nomeController.text = dados['name'] ?? '';
      emailController.text = dados['email'] ?? '';
    });
  }

  Future<void> _salvarAutomaticamente() async {
    await storage.saveForm(nomeController.text, emailController.text);
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário Auto-Save'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nomeController,
              onChanged: (_) => _salvarAutomaticamente(),
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              onChanged: (_) => _salvarAutomaticamente(),
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
