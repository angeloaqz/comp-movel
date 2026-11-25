# Roteiro de Aula 07 – Permissões e Acesso a Recursos em Aplicações Móveis

---

## Parte Teórica – Respostas dos Exercícios (1 a 5)

### Exercício 1 – Conceito fundamental
* **O que são permissões:** São mecanismos de segurança do sistema operacional (Android e iOS) que funcionam como autorizações que um aplicativo precisa obter antes de acessar recursos sensíveis do aparelho (como câmera, microfone, localização ou arquivos).
* **Por que existem e qual problema resolvem:** Elas evitam que aplicativos mal-intencionados espionem o usuário, gravem áudio/vídeo escondidos, rastreiem sua localização ou acessem documentos pessoais sem consentimento.
* **Controle e papel do usuário:** O sistema operacional gerencia o bloqueio técnico, mas é o **usuário** quem tem o poder de decisão explícita sobre conceder ou negar cada acesso.

### Exercício 2 – Runtime
A afirmação está incorreta porque atualmente as permissões sensíveis são gerenciadas em **runtime** (tempo de execução), ou seja, no exato momento em que o usuário está utilizando o aplicativo e tenta acionar uma funcionalidade que depende daquele recurso (ex.: clicar em "Tirar foto"). Além disso, o usuário pode revogar ou alterar permissões a qualquer momento nas configurações do aparelho. Em versões antigas do Android, todas as permissões eram aceitas de uma só vez durante a instalação, sem transparência ou controle granular.

### Exercício 3 – Classificação de permissões
* **Acesso à internet:** **Permissão normal.** Não acessa dados pessoais sensíveis nem hardware crítico diretamente, sendo concedida automaticamente pelo sistema.
* **Uso da câmera:** **Permissão perigosa.** Permite capturar fotos e vídeos do ambiente e do usuário, exigindo autorização explícita em runtime.
* **Vibração do dispositivo:** **Permissão normal.** Apenas aciona o motor de vibração sem expor privacidade ou dados do usuário.
* **Acesso à localização:** **Permissão perigosa.** Permite rastrear onde o usuário está em tempo real, oferecendo risco direto à privacidade física.
* **Leitura de contatos:** **Permissão perigosa.** Expõe informações pessoais e dados privados de terceiros armazenados no aparelho.

### Exercício 4 – Fluxo correto
* **Qual é o erro:** Tentar acionar o hardware da câmera diretamente sem antes verificar se a permissão foi concedida.
* **Problemas causados:** Pode gerar exceções em tempo de execução, travamentos (crash) no aplicativo ou falhas silenciosas em que nada acontece ao clicar no botão.
* **Fluxo correto passo a passo:**
  1. O usuário clica no botão "Tirar foto".
  2. O aplicativo verifica o status atual da permissão (`Permission.camera.status`).
  3. Se ainda não estiver concedida (`!status.isGranted`), solicita ao usuário (`Permission.camera.request()`).
  4. O usuário decide no diálogo do sistema operacional e o sistema retorna o novo status.
  5. O app reage conforme o retorno: se `granted`, abre a câmera; se `denied`, exibe aviso amigável; se `permanentlyDenied`, orienta e oferece abrir as configurações (`openAppSettings()`).

### Exercício 5 – Estados da permissão
* **Permissão negada (`denied`):** O usuário recusou o acesso naquela tentativa, mas não bloqueou futuros pedidos. Quando o app tentar solicitar novamente, o diálogo nativo de permissão será exibido outra vez. O comportamento correto é explicar por que o recurso é necessário e permitir que o usuário tente novamente.
* **Permissão negada permanentemente (`permanentlyDenied`):** O usuário recusou e marcou "Não perguntar novamente" (ou negou repetidas vezes). Quando o app tenta solicitar novamente, o sistema operacional ignora o pedido e não exibe mais o popup. O comportamento correto é informar que o recurso está bloqueado e direcionar o usuário para as configurações do aplicativo usando `openAppSettings()`.

---

## Parte Prática – Arquivos Implementados (Exercício 6 e Práticas 2 e 3)

> **Nota de configuração nativa:** Para executar em Android, declare `<uses-permission android:name="android.permission.CAMERA"/>` e `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>` no `AndroidManifest.xml`. No iOS, adicione `NSCameraUsageDescription` e `NSLocationWhenInUseUsageDescription` no `Info.plist`.

* **`pubspec.yaml`**: Dependências `permission_handler`, `image_picker`, `file_picker` e `path_provider` configuradas.
* **`lib/services/permission_service.dart`**: Camada de serviço desacoplada da UI para verificar e solicitar permissões de câmera, armazenamento e localização.
* **`lib/main.dart`**: Tela inicial com navegação para as 3 práticas implementadas.
* **`lib/screens/camera_screen.dart` (Exercício 6):** Fluxo completo de verificação/solicitação de permissão de câmera e captura de foto real com `ImagePicker`.
* **`lib/screens/text_file_screen.dart` (Exercício Prático 2):** Tela que permite digitar, salvar arquivos `.txt` localmente e abrir arquivos de texto do dispositivo.
* **`lib/screens/location_screen.dart` (Exercício Prático 3):** Tela dedicada à verificação e solicitação em runtime da permissão de localização (`Permission.locationWhenInUse`), tratando estados `granted`, `denied` e `permanentlyDenied`.
