import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  int get totalItems => _products.length;

  double get totalPrice {
    double total = 0;
    for (final product in _products) {
      total += product.preco;
    }
    return total;
  }

  void addProduct(Product product) {
    final nomeLimpo = product.nome.trim();
    if (nomeLimpo.isEmpty || product.preco <= 0) {
      return;
    }
    _products.add(Product(nome: nomeLimpo, preco: product.preco));
    notifyListeners();
  }

  void removeProduct(int index) {
    if (index < 0 || index >= _products.length) {
      return;
    }
    _products.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _products.clear();
    notifyListeners();
  }
}
