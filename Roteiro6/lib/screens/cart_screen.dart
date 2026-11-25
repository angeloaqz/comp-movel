import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _confirmarRemocao(BuildContext context, int index, String nomeProduto) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remover produto'),
        content: Text('Deseja remover "$nomeProduto" do carrinho?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remover'),
          ),
        ],
      ),
    );

    if (confirmar == true && context.mounted) {
      context.read<CartProvider>().removeProduct(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho (${cart.totalItems})'),
        actions: [
          if (cart.products.isNotEmpty)
            TextButton(
              onPressed: () {
                context.read<CartProvider>().clearCart();
              },
              child: const Text('Limpar carrinho'),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.products.isEmpty
                ? const Center(
                    child: Text('Seu carrinho está vazio.'),
                  )
                : ListView.builder(
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      final product = cart.products[index];
                      return ListTile(
                        title: Text(
                          '${product.nome} - R\$ ${product.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmarRemocao(context, index, product.nome),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: R\$ ${cart.totalPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: cart.products.isEmpty
                      ? null
                      : () {
                          context.read<CartProvider>().clearCart();
                        },
                  child: const Text('Limpar carrinho'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
