# TBL 04 – Background Execution, Notificações e Ciclo de Vida Real do App no Flutter

---

## Parte 1 – Exercícios Práticos Implementados

O projeto segue exatamente a arquitetura recomendada no roteiro (`models`, `services`, `repositories`, `viewmodels` e `views`):

* **Exercício 1 (`lib/services/lifecycle_service.dart` + `home_view.dart`):** Observa `AppLifecycleState` via `WidgetsBindingObserver` (`resumed`, `inactive`, `paused`, `detached`, `hidden`) e atualiza o estado atual na tela.
* **Exercício 2 (`lib/services/lifecycle_service.dart`):** Quando o aplicativo entra em background (`AppLifecycleState.paused`), salva automaticamente o horário atual no `SharedPreferences` e restaura o registro ao retornar ou reabrir o app.
* **Exercício 3 (`lib/services/background_service.dart`):** Configura o `Workmanager` com `callbackDispatcher` em nível superior (`@pragma('vm:entry-point')`), registrando tarefa periódica (`15 minutos`) e permitindo disparo imediato de sincronização fake com persistência do horário.
* **Exercício 4 (`lib/services/notification_service.dart` + `pedido_view.dart`):** Integra `FirebaseMessaging` tratando `onMessageOpenedApp` (background) e `getInitialMessage()` (terminated) para realizar deep linking abrindo diretamente a tela `PedidoView(pedidoId: id)` ao clicar na notificação.
* **Exercício 5 (`lib/views/chat_view.dart` + `app_viewmodel.dart`):** Sistema de mensagens que escuta `FirebaseMessaging.onMessage` (e possui botão de simulação local) para atualizar a conversa em tempo real enquanto o app está em foreground.

> **Nota de configuração nativa (Android):** No `android/app/src/main/AndroidManifest.xml`, declare `<uses-permission android:name="android.permission.WAKE_LOCK"/>`, `<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>` e `<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>`.

---

## Parte 2 – Respostas dos Exercícios Teóricos (1 a 5)

### 1. Qual a diferença entre foreground, background e terminated?
* **Foreground (`resumed`):** O aplicativo está aberto, visível na tela e o usuário está interagindo ativamente com ele. Possui prioridade máxima de CPU, rede e renderização.
* **Background (`paused`):** O usuário minimizou o aplicativo ou trocou para outro app. A interface deixa de ser renderizada e o sistema operacional passa a restringir timers, rede e processamento para economizar bateria e memória.
* **Terminated (`detached` / processo encerrado):** O aplicativo foi completamente fechado pelo usuário ou teve seu processo morto pelo sistema operacional. Nenhuma variável em memória sobrevive a esse estado.

### 2. Por que o Android limita execução em background?
Para preservar **bateria**, liberar **memória RAM** e garantir desempenho e estabilidade para o aplicativo que está em primeiro plano (foreground), evitando que apps ocultos consumam CPU, dados móveis e energia indefinidamente.

### 3. Por que `Timer.periodic` não é confiável em apps reais?
Porque o `Timer.periodic` existe apenas na memória do processo Dart ativo. Quando o app vai para background, o Android congela timers, entra em *Doze Mode* ou mata o processo do aplicativo a qualquer momento para recuperar memória, interrompendo a execução sem garantia de retomada. Para tarefas reais em segundo plano, deve-se usar ferramentas gerenciadas pelo sistema como o **WorkManager**.

### 4. Explique o fluxo: Servidor → FCM → Android → Flutter
1. **Servidor:** O backend detecta um evento (ex.: pedido mudou para *"Saiu para entrega"*) e envia uma requisição com o payload e o token do dispositivo para a API do Firebase.
2. **FCM (Firebase Cloud Messaging):** Recebe a mensagem do servidor e a roteia de forma otimizada para o serviço de mensageria do sistema operacional do aparelho.
3. **Android:** O sistema operacional recebe o push mesmo se o app estiver fechado; exibe a notificação na barra de status (se em background/terminated) ou entrega os dados diretamente ao processo do app (se em foreground).
4. **Flutter:** O plugin `firebase_messaging` captura o evento (`onMessage`, `onMessageOpenedApp` ou `getInitialMessage`), atualiza o estado da interface ou navega para a tela específica (deep linking).

### 5. Qual a diferença entre `onMessage`, `onMessageOpenedApp` e `getInitialMessage`?
* **`FirebaseMessaging.onMessage`:** Disparado quando uma notificação chega enquanto o aplicativo está aberto em **foreground** (primeiro plano). Não exibe banner automático no Android, permitindo que o app atualize a tela diretamente (como um chat).
* **`FirebaseMessaging.onMessageOpenedApp`:** Disparado quando o aplicativo estava minimizado em **background** (ainda vivo na memória) e o usuário toca na notificação na barra do sistema para trazê-lo de volta.
* **`FirebaseMessaging.instance.getInitialMessage()`:** Utilizado quando o aplicativo estava totalmente fechado (**terminated**) e foi aberto a partir do toque do usuário na notificação, permitindo recuperar os dados da notificação inicial ao iniciar o app.
