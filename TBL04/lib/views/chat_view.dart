import 'package:flutter/material.dart';
import '../viewmodels/app_viewmodel.dart';

class ChatView extends StatefulWidget {
  final AppViewModel viewModel;

  const ChatView({super.key, required this.viewModel});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _msgController = TextEditingController();

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
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mensagens = widget.viewModel.mensagens;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversa em Foreground'),
        actions: [
          IconButton(
            tooltip: 'Simular Push em Foreground',
            onPressed: () {
              widget.viewModel.receberMensagemForeground(
                'Entregador',
                'Cheguei na portaria com seu pedido!',
              );
            },
            icon: const Icon(Icons.mark_chat_unread),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: mensagens.length,
              itemBuilder: (context, index) {
                final item = mensagens[index];
                return Card(
                  child: ListTile(
                    title: Text(item.remetente),
                    subtitle: Text(item.texto),
                    trailing: Text(
                      '${item.horario.hour.toString().padLeft(2, '0')}:${item.horario.minute.toString().padLeft(2, '0')}',
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      labelText: 'Digite uma mensagem',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    widget.viewModel.enviarMensagem(_msgController.text);
                    _msgController.clear();
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
