# Roteiro de Aula 06 – Gerenciamento de Estado no Flutter (Provider)

Aplicação desenvolvida seguindo a arquitetura recomendada (`models`, `providers` e `screens`) com **Provider**, integrando de forma incremental todos os 7 exercícios e desafios adicionais propostos:

## Estrutura de Pastas

```text
pubspec.yaml
lib/
 ├── main.dart
 ├── models/
 │    └── product.dart
 ├── providers/
 │    └── cart_provider.dart
 └── screens/
      ├── store_screen.dart
      └── cart_screen.dart
```

## Funcionalidades Integradas (Exercícios 1 a 7)

* **Exercício 1 (`CartProvider` e validação):** Estado centralizado com `ChangeNotifier`, validação que impede adicionar nomes vazios ou apenas com espaços e atualização reativa sem `setState()` para a lista.
* **Exercício 2 (Remoção com confirmação):** Método `removeProduct(int index)` com botão de exclusão e diálogo de confirmação (`AlertDialog`) antes de remover o item.
* **Exercício 3 (`StoreScreen` e `CartScreen`):** Duas telas independentes compartilhando a mesma instância de `CartProvider` via `ChangeNotifierProvider`.
* **Exercício 4 (Contador reativo):** Getter `totalItems` exibido dinamicamente no título do AppBar (`Carrinho (X)`).
* **Exercício 5 (`Product` model):** Evolução de `List<String>` para `List<Product>` com `nome` e `preco`.
* **Exercício 6 (Cálculo do total):** Getter `totalPrice` no `CartProvider` exibido no rodapé do carrinho no formato `Total: R$ X,XX`.
* **Exercício 7 (Limpar carrinho):** Método `clearCart()` acionado pelo botão **"Limpar carrinho"**, zerando a lista, o contador e o valor total.
