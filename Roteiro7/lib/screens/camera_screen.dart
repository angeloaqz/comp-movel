import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/permission_service.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> tirarFoto() async {
    final XFile? imagem = await _picker.pickImage(source: ImageSource.camera);
    if (imagem != null) {
      return File(imagem.path);
    }
    return null;
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final PermissionService permissionService = PermissionService();
  final CameraService cameraService = CameraService();
  File? imagem;
  String mensagem = 'Nenhuma ação realizada';

  Future<void> abrirCamera() async {
    var status = await permissionService.verificarCamera();

    if (!status.isGranted) {
      status = await permissionService.solicitarCamera();
    }

    if (status.isGranted) {
      final foto = await cameraService.tirarFoto();
      setState(() {
        imagem = foto;
        mensagem = foto != null ? 'Foto capturada!' : 'Captura cancelada.';
      });
    } else if (status.isPermanentlyDenied) {
      setState(() {
        mensagem = 'Permissão bloqueada. Vá nas configurações.';
      });
      await openAppSettings();
    } else {
      setState(() {
        mensagem = 'Permissão negada.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Câmera Real'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mensagem),
              const SizedBox(height: 20),
              if (imagem != null)
                Image.file(imagem!, height: 250),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: abrirCamera,
                child: const Text('Tirar Foto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
