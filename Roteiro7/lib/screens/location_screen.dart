import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/permission_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final PermissionService permissionService = PermissionService();
  String _statusLocalizacao = 'Permissão de localização ainda não solicitada.';

  Future<void> _solicitarLocalizacao() async {
    var status = await permissionService.verificarLocalizacao();

    if (!status.isGranted) {
      status = await permissionService.solicitarLocalizacao();
    }

    if (status.isGranted) {
      setState(() {
        _statusLocalizacao = 'Permissão de localização concedida!';
      });
    } else if (status.isPermanentlyDenied) {
      setState(() {
        _statusLocalizacao = 'Permissão negada permanentemente. Abra as configurações.';
      });
      await openAppSettings();
    } else {
      setState(() {
        _statusLocalizacao = 'Permissão de localização negada.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissão de Localização'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 70, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _statusLocalizacao,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _solicitarLocalizacao,
                child: const Text('Solicitar Localização'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
