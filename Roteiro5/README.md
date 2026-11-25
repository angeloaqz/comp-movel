# Roteiro de Aula 05 – Persistência de Dados no Flutter

Projeto organizado nas camadas `lib/services` e `lib/screens` utilizando `shared_preferences`, integrando todas as atividades práticas propostas:

## Estrutura de Pastas

```text
pubspec.yaml
lib/
 ├── main.dart
 ├── services/
 │    └── storage_service.dart
 └── screens/
      ├── task_screen.dart
      ├── last_page_screen.dart
      ├── autosave_form_screen.dart
      └── cart_screen.dart
```

## Exercícios Implementados

* **Exercícios 1 e 2 (`task_screen.dart`):** Evolução da lista de tarefas persistente adicionando o botão **"Limpar tudo"** (que apaga os dados no `SharedPreferences`) e a exibição da mensagem **"Nenhuma tarefa cadastrada."** quando a lista está vazia.
* **Exercício 3 (`last_page_screen.dart`):** Tela com os botões `"Página A"`, `"Página B"` e `"Página C"` que persiste a última página selecionada e a restaura automaticamente ao recarregar o aplicativo.
* **Exercício 4 (`autosave_form_screen.dart`):** Formulário com campos **Nome** e **Email** com salvamento automático via `onChanged` do `TextField`, mantendo os valores preenchidos ao recarregar.
* **Exercício 5 (`cart_screen.dart`):** Lista fixa de produtos (`Produto A`, `Produto B` e `Produto C`) com botão **"Adicionar ao carrinho"** e persistência dos itens adicionados no armazenamento local.
