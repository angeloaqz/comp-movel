# TBL 01 – Navegação entre Telas no Flutter

---

## Arquivos Implementados

* **`exercicio1_navegacao_basica.dart`**: Navegação simples entre `TelaInicial` e `TelaDetalhe` utilizando `Navigator.push` e `Navigator.pop`.
* **`exercicio2_enviando_dados.dart`**: Envio da `String` `"Maria"` de `Tela1` para `Tela2` via construtor, exibindo `"Olá, Maria"` sem variáveis globais ou `setState`.
* **`exercicio3_e_4_retorno_dados.dart`**: Versão final evoluída (Exercício 3 + Exercício 4) onde `Tela1` aguarda o retorno com `async/await` e atualiza o estado via `setState`, enquanto `Tela2` permite escolher os botões fixos (`10` ou `20`) ou digitar qualquer número em um `TextField`.
* **`exercicio5_grupo/`**: Fluxo completo em 3 telas integradas (simulando a divisão entre os 3 participantes do grupo):
  * `main.dart` e `tela_inicial.dart` (Participante 1): Inicia o fluxo e aguarda com `async/await` o retorno da confirmação.
  * `tela_cadastro.dart` (Participante 2): Coleta `nome` e `idade` nos `TextField` e repassa via construtor para `TelaConfirmacao`.
  * `tela_confirmacao.dart` (Participante 3): Exibe os dados recebidos e possui os botões **Confirmar** (retorna o resultado com `Navigator.pop(context, valor)`) e **Voltar**.

---

## Respostas das Perguntas de Discussão

### Exercício 2 – Passagem de Dados via Construtor
* **Por que usamos construtor?** Porque o construtor é a forma segura e explícita de exigir e inicializar os dados necessários no momento em que a nova tela é instanciada, evitando acoplamento e variáveis globais.
* **Por que `Tela2` pode ser `Stateless`?** Porque ela apenas recebe a informação uma única vez ao ser construída e a exibe na interface, sem precisar alterar esse valor internamente depois.
* **O dado pode mudar depois que a tela é criada?** Não dentro do próprio `StatelessWidget` (já que o atributo é `final`). Para exibir outro valor, seria necessário criar uma nova instância da tela passando um novo argumento.

### Exercício 3 – Retorno de Dados com `async/await`
* **O que acontece se remover o `await`?** O código não espera o usuário fechar a `Tela2`; a variável `resultado` recebe imediatamente um objeto `Future` pendente em vez do valor inteiro, e a atualização da tela não funciona como esperado.
* **O que acontece se remover `async`?** O compilador gera erro de sintaxe porque a palavra-chave `await` só pode ser utilizada dentro de funções marcadas como `async`.
* **O que é `Future`?** É um objeto que representa um valor (ou erro) que ainda não está disponível no momento, mas que será concluído no futuro (neste caso, quando o usuário clicar em algum botão ou voltar da `Tela2`).
* **Quando o valor realmente é recebido?** No exato momento em que a `Tela2` executa `Navigator.pop(context, valor)` (ou quando o usuário fecha a tela pelo botão voltar do sistema, retornando `null`).
