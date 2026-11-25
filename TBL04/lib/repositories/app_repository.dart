import 'package:shared_preferences/shared_preferences.dart';
import '../models/pedido.dart';
import '../models/mensagem_chat.dart';

class AppRepository {
  static const String _ultimoPedidoKey = 'ultimoPedido';

  Future<void> salvarUltimoPedido(String pedidoId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_ultimoPedidoKey, pedidoId);
  }

  Future<String> carregarUltimoPedido() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_ultimoPedidoKey) ?? '123';
  }

  Pedido buscarPedidoPorId(String id) {
    return Pedido(
      id: id,
      descricao: 'Combo Lanche + Bebida',
      status: 'Saiu para entrega',
    );
  }

  List<MensagemChat> carregarMensagensIniciais() {
    return [
      MensagemChat(
        remetente: 'Entregador',
        texto: 'Pedido retirado no restaurante.',
        horario: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    ];
  }
}
