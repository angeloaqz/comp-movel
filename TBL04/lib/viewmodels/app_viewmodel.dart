import 'package:flutter/foundation.dart';
import '../models/mensagem_chat.dart';
import '../repositories/app_repository.dart';
import '../services/background_service.dart';
import '../services/lifecycle_service.dart';

class AppViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepository();
  final BackgroundService _backgroundService = BackgroundService();
  late final LifecycleService _lifecycleService;

  String estadoLifecycle = 'Aplicativo iniciado';
  String ultimoHorarioBackground = 'Nenhum registro ainda';
  String ultimaSincronizacao = 'Carregando...';
  final List<MensagemChat> mensagens = [];

  AppViewModel() {
    _lifecycleService = LifecycleService(
      onStateChanged: (estado, ultimoBg) {
        estadoLifecycle = estado;
        if (ultimoBg != null) {
          ultimoHorarioBackground = ultimoBg;
        }
        notifyListeners();
      },
    );
    _lifecycleService.iniciar();
    mensagens.addAll(_repository.carregarMensagensIniciais());
    _carregarDadosPersistidos();
  }

  Future<void> _carregarDadosPersistidos() async {
    final bgSalvo = await _lifecycleService.carregarUltimoHorarioBackground();
    if (bgSalvo != null) {
      ultimoHorarioBackground = bgSalvo;
    }
    ultimaSincronizacao = await _backgroundService.obterUltimaSincronizacao();
    notifyListeners();
  }

  Future<void> dispararSyncBackground() async {
    await _backgroundService.executarSincronizacaoUnicaAgora();
    await Future.delayed(const Duration(seconds: 3));
    ultimaSincronizacao = await _backgroundService.obterUltimaSincronizacao();
    notifyListeners();
  }

  void receberMensagemForeground(String remetente, String texto) {
    mensagens.add(
      MensagemChat(
        remetente: remetente,
        texto: texto,
        horario: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void enviarMensagem(String texto) {
    final limpo = texto.trim();
    if (limpo.isEmpty) return;
    mensagens.add(
      MensagemChat(
        remetente: 'Você',
        texto: limpo,
        horario: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _lifecycleService.encerrar();
    super.dispose();
  }
}
