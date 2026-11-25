import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const String syncTaskUniqueName = 'syncTask';
const String syncTaskName = 'sincronizarDados';
const String lastSyncKey = 'ultima_sincronizacao_bg';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == syncTaskName) {
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(lastSyncKey, DateTime.now().toIso8601String());
    }
    return Future.value(true);
  });
}

class BackgroundService {
  Future<void> inicializar() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  Future<void> registrarSincronizacaoPeriodica() async {
    await Workmanager().registerPeriodicTask(
      syncTaskUniqueName,
      syncTaskName,
      frequency: const Duration(minutes: 15),
    );
  }

  Future<void> executarSincronizacaoUnicaAgora() async {
    await Workmanager().registerOneOffTask(
      'syncOnce_${DateTime.now().millisecondsSinceEpoch}',
      syncTaskName,
    );
  }

  Future<String> obterUltimaSincronizacao() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastSyncKey) ?? 'Nenhuma sincronização realizada ainda.';
  }
}
