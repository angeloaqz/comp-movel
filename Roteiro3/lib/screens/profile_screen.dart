import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/title_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 80, color: Colors.orange),
            const SizedBox(height: 12),
            const TitleText(texto: 'Perfil do Usuário'),
            const SizedBox(height: 20),
            CustomButton(
              texto: 'Voltar',
              cor: Colors.orange,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
