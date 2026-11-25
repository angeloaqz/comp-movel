import 'package:flutter/material.dart';
import 'screens/camera_screen.dart';
import 'screens/text_file_screen.dart';
import 'screens/location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPermissoesScreen(),
    );
  }
}

class MenuPermissoesScreen extends StatelessWidget {
  const MenuPermissoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roteiro 7 - Permissões'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CameraScreen()),
                    );
                  },
                  child: const Text('Prática 1 - Câmera Real'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TextFileScreen()),
                    );
                  },
                  child: const Text('Prática 2 - Arquivos de Texto'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LocationScreen()),
                    );
                  },
                  child: const Text('Prática 3 - Localização'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
