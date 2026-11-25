import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  final List<Product> _catalogo = [
    Product(nome: 'Arroz', preco: 5.00),
    Product(nome: 'Feijão', preco: 8.50),
    Product(nome: 'Macarrão', preco: 4.20),
    Product(nome: 'Café', preco: 15.00),
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _adicionarProdutoPersonalizado() {
    final nome = _nomeController.text.trim();
    final preco = double.tryParse(_precoController.text.replaceAll(',', '.')) ?? 0.0;

    if (nome.isEmpty || preco <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe um nome válido e preço maior que zero.')),
      );
      return;
    }

    context.read<CartProvider>().addProduct(Product(nome: nome, preco: preco));
    _nomeController.clear();
    _precoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final totalItems = context.watch<CartProvider>().totalItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            label: Text('Carrinho ($totalItems)'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adicionar Produto Personalizado',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _precoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Preço',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _adicionarProdutoPersonalizado,
                  child: const Text('Adicionar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Produtos da Loja',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _catalogo.length,
                itemBuilder: (context, index) {
                  final item = _catalogo[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.nome),
                      subtitle: Text('R\$ ${item.preco.toStringAsFixed(2).replaceAll('.', ',')}'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          context.read<CartProvider>().addProduct(item);
                        },
                        child: const Text('Adicionar ao carrinho'),
                      ),
                    ),
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
