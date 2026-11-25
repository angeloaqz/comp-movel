import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final StorageService storage = StorageService();
  final List<String> produtos = const [
    'Produto A',
    'Produto B',
    'Produto C',
  ];
  List<String> carrinho = [];

  @override
  void initState() {
    super.initState();
    _carregarCarrinho();
  }

  Future<void> _carregarCarrinho() async {
    final salvos = await storage.loadCart();
    setState(() {
      carrinho = salvos;
    });
  }

  Future<void> _adicionarAoCarrinho(String produto) async {
    setState(() {
      carrinho.add(produto);
    });
    await storage.saveCart(carrinho);
  }

  Future<void> _limparCarrinho() async {
    setState(() {
      carrinho.clear();
    });
    await storage.saveCart(carrinho);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho Persistente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produtos Disponíveis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...produtos.map(
              (produto) => Card(
                child: ListTile(
                  title: Text(produto),
                  trailing: ElevatedButton(
                    onPressed: () => _adicionarAoCarrinho(produto),
                    child: const Text('Adicionar ao carrinho'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Itens no Carrinho',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _limparCarrinho,
                  child: const Text('Limpar'),
                ),
              ],
            ),
            Expanded(
              child: carrinho.isEmpty
                  ? const Center(child: Text('Carrinho vazio.'))
                  : ListView.builder(
                      itemCount: carrinho.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: Text(carrinho[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
