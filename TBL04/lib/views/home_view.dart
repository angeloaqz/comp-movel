import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';
import 'chat_view.dart';
import 'pedido_view.dart';

class HomeView extends StatefulWidget {
  final AppViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(_atualizar);
  }

  void _atualizar() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_atualizar);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifecycle, Background e Push'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.sync_alt),
                title: const Text('Exercício 1 - Estado Atual do Lifecycle'),
                subtitle: Text(widget.viewModel.estadoLifecycle),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Exercício 2 - Último Horário em Background'),
                subtitle: Text(widget.viewModel.ultimoHorarioBackground),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Exercício 3 - WorkManager (Sincronização Background)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text('Última sync: ${widget.viewModel.ultimaSincronizacao}'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: widget.viewModel.dispararSyncBackground,
                      child: const Text('Executar Sincronização Fake'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PedidoView(pedidoId: '123'),
                  ),
                );
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text('Exercício 4 - Simular Clique Push (Pedido #123)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatView(viewModel: widget.viewModel),
                  ),
                );
              },
              icon: const Icon(Icons.chat),
              label: const Text('Exercício 5 - Chat em Foreground'),
            ),
          ],
        ),
      ),
    );
  }
}
