import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/title_text.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleText(texto: 'Tela de Detalhes'),
            const SizedBox(height: 20),
            CustomButton(
              texto: 'Voltar',
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
