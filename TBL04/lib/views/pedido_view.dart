import 'package:flutter/material.dart';
import '../repositories/app_repository.dart';

class PedidoView extends StatelessWidget {
  final String pedidoId;

  const PedidoView({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context) {
    final repository = AppRepository();
    final pedido = repository.buscarPedidoPorId(pedidoId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido #${pedido.id}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.delivery_dining, size: 64, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    'Pedido #${pedido.id}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(pedido.descricao, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${pedido.status}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
