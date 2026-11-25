# Roteiro – Ciclo de Vida de Widgets e Consumo de API no Flutter

Projeto organizado nas camadas `lib/models`, `lib/services` e `lib/screens`, integrando as duas partes práticas propostas no roteiro:

## Estrutura de Pastas

```text
pubspec.yaml
lib/
 ├── main.dart
 ├── models/
 │    └── pokemon.dart
 ├── services/
 │    └── pokemon_service.dart
 └── screens/
      ├── mensagem_lifecycle_screen.dart
      └── pokemon_screen.dart
```

## Atividades Implementadas

### 1. Ciclo de Vida de Widgets (`mensagem_lifecycle_screen.dart`)
Implementa a tela `MensagemLifecycleScreen` como `StatefulWidget` contendo:
* Logs no console em `initState()` (`"Tela iniciada"`), `build()` (`"Tela reconstruída"`) e `dispose()` (`"Tela finalizada"`).
* `TextEditingController` devidamente liberado dentro do `dispose()`.
* Controle de visibilidade booleana (`mensagemVisivel = true`) alternado por botão via `setState()`.
* Botão `"Fechar tela"` utilizando `Navigator.pop(context)`.

### 2. Consumo de API – Pokédex (`pokemon.dart`, `pokemon_service.dart` e `pokemon_screen.dart`)
Versão final consolidada após todos os 8 passos incrementais (Exercícios 1 a 7 + Exercício Final):
* Carregamento inicial automático no `initState()` buscando o Pokémon inicial (`1`).
* Exibição de nome formatado, número (`id`), imagem oficial (`Image.network`) e tratamento de erro com mensagem visual.
* Campo de busca (`TextField`) por nome ou número e botão para reproduzir o som do Pokémon (`audioplayers`).
* Botões **"Anterior"** e **"Próximo"** para navegar sequencialmente entre os Pokémons pelo número.

## Resposta da Reflexão Inicial
* **Por que não colocar toda a lógica da tela dentro do `build()`?**
  Porque o método `build()` pode ser executado dezenas de vezes durante o ciclo de vida do widget (a cada `setState()`, rotação de tela ou animação). Colocar requisições HTTP, inicializações ou lógicas pesadas dentro dele faria essas operações rodarem repetidamente sem necessidade, causando lentidão e consumo excessivo de recursos.
