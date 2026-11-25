# Roteiro de Aula 02 – Layout no Flutter

---

## Arquivos Implementados

* **`exercicio1_layout_evento.dart`**: Tela estruturada com `Scaffold`, `AppBar`, `Column`, `Icon`, dois `Text`, `SizedBox` e `ElevatedButton` com contexto de evento.
* **`exercicio2_row_acoes.dart`**: `Row` com três ações (`Início`, `Pesquisar` e `Perfil`) utilizando `MainAxisAlignment.spaceEvenly`.
* **`exercicio3_cartao_produto.dart`**: Cartão de produto estilizado com `Container`, `Padding`, `Column`, `Row` e `Expanded` para distribuir preço e botão.
* **`exercicio4_colunas_proporcionais.dart`**: `Row` dividida em dois blocos usando `Expanded` com proporção `flex: 2` (informações) e `flex: 1` (imagem/ícone).
* **`exercicio5_perfil_responsivo.dart`**: Tela de perfil que alterna entre organização vertical (`Column`) em telas estreitas e horizontal (`Row` + `Flexible`) em telas largas.

---

## Explicações Pedidas nos Exercícios Práticos

### Exercício 2 – Diferença visual entre `spaceBetween`, `spaceAround` e `spaceEvenly`
* **`spaceBetween`**: Coloca o primeiro item encostado na borda esquerda, o último na borda direita e divide o espaço restante igualmente apenas entre os elementos internos (sem espaço nas pontas).
* **`spaceAround`**: Distribui espaços iguais ao redor de cada item; com isso, o espaço entre dois itens vizinhos fica o dobro do espaço das extremidades esquerda e direita.
* **`spaceEvenly`**: Distribui exatamente o mesmo tamanho de espaço tanto entre os itens quanto nas extremidades esquerda e direita.

### Exercício 4 – Por que a proporção mudou de `1:1` para `2:1`?
Com ambos em `flex: 1`, a soma dos fatores é 2, então cada bloco recebe `1/2` (50%) da largura disponível. Ao mudar o primeiro para `flex: 2` e manter o segundo em `flex: 1`, a soma passa a ser 3; assim, o bloco esquerdo ocupa `2/3` (~66,6%) do espaço e o bloco direito ocupa `1/3` (~33,3%).

---

## Respostas das Verificações e Teste Final

### Verificação Rápida (Página 6)
1. **`Scaffold`** fornece a estrutura básica visual da tela.
2. **`Center`** está diretamente dentro de `body`.
3. **`Text`** exibe o texto na tela.

### Exercício de Raciocínio (Página 9)
Para colocar três botões no centro vertical de uma `Column` e alinhados à esquerda na horizontal, usa-se `mainAxisAlignment: MainAxisAlignment.center` e `crossAxisAlignment: CrossAxisAlignment.start`.

### Teste Final (Página 19)
1. **Diferença entre `Row` e `Column`:** `Row` organiza os widgets filhos lado a lado (horizontalmente); `Column` organiza um abaixo do outro (verticalmente).
2. **Eixo principal da `Column`:** Vertical.
3. **Propriedade que controla a distribuição horizontal na `Row`:** `mainAxisAlignment`.
4. **Diferença entre `Padding` e `SizedBox`:** `Padding` cria um espaçamento interno ao redor de um widget filho; `SizedBox` cria uma caixa com largura/altura fixa, muito usada para dar espaço vazio entre dois widgets.
5. **Para que serve `Expanded`:** Faz o widget filho ocupar todo o espaço livre disponível no eixo principal de uma `Row` ou `Column` (podendo dividir proporcionalmente via `flex`).
6. **Por que largura fixa causa problemas:** Porque dispositivos têm tamanhos de tela diferentes; em telas menores um valor fixo pode estourar a largura (overflow) e em telas maiores pode deixar sobras mal aproveitadas.
7. **O que significa "constraints descem, tamanhos sobem":** O widget pai passa os limites mínimos e máximos (constraints) para o filho; o filho escolhe seu tamanho respeitando esses limites e informa de volta ao pai, que então define onde posicioná-lo.
8. **Widget para três botões verticalmente:** `Column`.
9. **Widget para três ícones lado a lado:** `Row`.
10. **Perguntas antes de diminuir elementos em caso de overflow:** "Qual widget pai está passando as constraints para este widget?" e "Esse layout precisa de rolagem ou divisão flexível (`Expanded`/`Flexible`) em vez de tamanho fixo?".
