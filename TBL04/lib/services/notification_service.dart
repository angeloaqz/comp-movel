import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> configurar({
    required void Function(String pedidoId) onAbrirPedido,
    required void Function(String titulo, String corpo) onMensagemForeground,
  }) async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final titulo = message.notification?.title ?? 'Nova mensagem';
      final corpo = message.notification?.body ?? '';
      onMensagemForeground(titulo, corpo);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final pedidoId = message.data['pedidoId']?.toString() ?? '123';
      onAbrirPedido(pedidoId);
    });

    final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      final pedidoId = initialMessage.data['pedidoId']?.toString() ?? '123';
      onAbrirPedido(pedidoId);
    }
  }

  Future<String?> obterToken() async {
    return await _messaging.getToken();
  }
}
