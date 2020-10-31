# Talpa - avaliação intercalar 

## Identificação 
- __Trabalho__: Talpa  
- __Grupo__: 3  
- __Turma Prática__: 3MIEIC06
- __Elementos__: 
-- Alexandre Almeida de Abreu Filho (up201800168)
-- Juliane de Lima Marubayashi (up201800175)

## Descrição do jogo
Talpa é jogo de dois jogadores geralemente disputado num tabuleiro 8x8. O objetivo do jogo é capturar as peças do jogador inimigo de forma a criar um caminho de espaços vazios, ortogonalmente conectados, de modo a conectar duas margens opostas no tabuleiro com casas vazias.  
Inicialmente, o jogo é preenchido com peças pretas e brancas dispostas como um tabuleiro de xadrez.  
Um jogador pode mover uma de suas peças capturando uma peça inimiga na casa vertical ou horizontal adjacente. A peça capturada é removida do tabuleiro e substituída por uma peça do jogador que realizou o movimento.  
A captura é obrigatória quando possível. No entanto, se não possível um jogador deve remover uma de suas peças em seu turno.  



__Nota__: As peças do tabuleiro não precisam ser necessariamente pretas e brancas. É preciso apenas que se possa distinguir as peças de cada jogador. No caso utilizamos `x` e `o`.  

## Representação interna do estado do jogo
- O estado do jogo é representado por uma lista de listas. Onde a representação das peças é feita da seguinte forma:  
-- 0: Casas vazias  
-- 1: Peças do jogador 1  
-- 2: Peças do jogador 2  
- Como há apenas dois jogadores, há dois possíveis valores para a variável do jogador atual: 1 ou 2.   
- Se as laterais verticais se conectarem o player 2 ganha. Se as laterais horizontais se contectarem o player 1 ganha.  

### Estados possíveis de jogo:
- Inicial:   
![](https://i.imgur.com/nikdIBR.png)   


- Intermédio:   
![](https://i.imgur.com/S6i2RDN.png)  


- Final:   
![](https://i.imgur.com/VY4Aj3J.png)  

## Visualização do estado do jogo
Para a explicação da visualização do jogo é preciso ter em mente a existência das seguintes funções principais: 
- print_matrix  
- print_columns  
- print_middle_matrix  
- print_last_row  

A função principal é a `print_matrix` que encarrega-se de chamar todas as outras funções.  
Para desenhar a primeira linha é preciso chamar a função `print_columns` que irá se encarregar de imprimir as letras correspondentes às colunas.  
Em seguida, a função `print_middle_matrix` irá imprimir o resto da matriz começando pelo número da linha seguido da posição das peças (de cada célula) da linha em questão.  
Ao chegar na última linha a ser impressa a função `print_middle_matrix` irá chamar a função `print_last_row` que irá printar os elementos e a borda inferior do tabuleiro.  

font:   
[BoardGameGeek](https://boardgamegeek.com/boardgame/80657/talpa)  
[Igg Game Center](http://www.iggamecenter.com/info/pt/talpa.html)
