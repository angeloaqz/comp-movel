import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifecycleService with WidgetsBindingObserver {
  static const String _ultimoHorarioBgKey = 'ultimo_horario_background';
  final void Function(String estado, String? ultimoBg) onStateChanged;

  LifecycleService({required this.onStateChanged});

  void iniciar() {
    WidgetsBinding.instance.addObserver(this);
  }

  void encerrar() {
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<String?> carregarUltimoHorarioBackground() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_ultimoHorarioBgKey);
  }

  Future<String> _salvarHorarioBackground() async {
    final prefs = await SharedPreferences.getInstance();
    final agora = DateTime.now().toIso8601String();
    await prefs.setString(_ultimoHorarioBgKey, agora);
    return agora;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        final ultimo = await carregarUltimoHorarioBackground();
        onStateChanged('App em foreground (resumed)', ultimo);
        break;
      case AppLifecycleState.inactive:
        onStateChanged('App inativo (inactive)', null);
        break;
      case AppLifecycleState.paused:
        final salvo = await _salvarHorarioBackground();
        onStateChanged('App em background (paused)', salvo);
        break;
      case AppLifecycleState.detached:
        onStateChanged('App encerrado (detached)', null);
        break;
      case AppLifecycleState.hidden:
        onStateChanged('App oculto (hidden)', null);
        break;
    }
  }
}
