import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> verificarCamera() async {
    return await Permission.camera.status;
  }

  Future<PermissionStatus> solicitarCamera() async {
    return await Permission.camera.request();
  }

  Future<PermissionStatus> verificarLocalizacao() async {
    return await Permission.locationWhenInUse.status;
  }

  Future<PermissionStatus> solicitarLocalizacao() async {
    return await Permission.locationWhenInUse.request();
  }

  Future<PermissionStatus> verificarArmazenamento() async {
    return await Permission.storage.status;
  }

  Future<PermissionStatus> solicitarArmazenamento() async {
    return await Permission.storage.request();
  }
}
