import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Exercicio5Page(),
  ));
}

class Exercicio5Page extends StatelessWidget {
  const Exercicio5Page({super.key});

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final telaLarga = largura > 600;

    final avatar = const CircleAvatar(
      radius: 45,
      child: Icon(Icons.person, size: 45),
    );

    final info = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: telaLarga ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        const Text(
          'Gabriel Almeida',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text('Desenvolvedor Mobile | Sistemas de Informação'),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Editar Perfil'),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil Responsivo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: telaLarga
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    avatar,
                    const SizedBox(width: 24),
                    Flexible(child: info),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    avatar,
                    const SizedBox(height: 16),
                    info,
                  ],
                ),
        ),
      ),
    );
  }
}
