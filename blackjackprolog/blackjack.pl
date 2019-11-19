:- initialization main.
:- use_module(library(random)).
:- use_module(library(lists)).

card("Aś",  1).
card("2",   2).
card("3",   3).
card("4",   4).
card("5",   5).
card("6",   6).
card("7",   7).
card("8",   8).
card("9",   9).
card("10", 10).
card("J",  10).
card("Q",  10).
card("K",  10).

cartas(Cartas):-
    Cartas = ["Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
    "Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
    "Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
    "Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"].

menu1jogador:-
    writeln('Qual o seu nome jogador?'),
    lerString(Jogador1),
    format('~w se prepare, o jogo vai começar!', [Jogador1]),
    writeln('Quer jogar? s/n'),
    lerString(E),
    verifica_resp(E, 1, C),
    nl.


menu2jogadores:-
    writeln('Qual o nome do primeiro jogador?'), nl,
    read_line_to_string(user_input, Nome1), nl,
    writeln('Qual o nome do primeiro jogador?'), nl,
    read_line_to_string(user_input, Nome2), nl,
    format('~w e ~w se preparem, o jogo vai começar!', [Nome1, Nome2]), nl.
    


menu_instrucoes:-
    writeln('BlackJack é um jogo que usa um baralho francês de 52 cartas para definir a pontuação.'),
    writeln('Um baralho francõs possui cartas de numeração de 2 a 10, onde no BlackJack equivale a uma pontuação proporcional a numeração.'),
    writeln('Também ha cartas especiais que são A, J, Q, K. As cartas J, Q e K valem 10 pontos, já a carta A pode assumir o valor de 1 ou de 11 dependendo da sua pontuação atual'),
    writeln('O jogador que juntar 21 pontos ou chegar mais próximo dos 21 é o ganhador!'),
    writeln('O jogo começa dando uma carta inicial para o jogador e ele pode decidir entre pedir outra carta ou parar com a pontuação que tem.'),
    writeln('Caso o jogador ultrapasse os 21 pontos ele perde, porém se o outro jogador também ultrapassar os 21 pontos então é declarado um empate.'), nl,
    writeln('Digite "y" para voltar ao menu inicial?'), nl,
    lerString(Escolhe),
    voltar_menu(Escolhe).

voltar_menu("y"):-
    nl,
    menu.

voltar_menu(_):-
    repeat,
    read_line_to_string(user_input,Escolhe),nl,
    voltar_menu(Escolhe).

opcao("1"):-
    menu2jogadores.

opcao("2"):-
    menu1jogador.

opcao("3"):-
    menu_instrucoes.

opcao("4"):-
    nl, writeln('Obrigado por ter jogado BlackJack!'), nl,
    halt.

player1(Cartas):-
    retira_carta(Cartas, E, NewList).


player2(Cartas):-
    retira_carta(Cartas, E, NewList).


playerpc(Cartas):-
retira_carta(Cartas, E, NewList).

verifica_resp("n", 1, 2):-
    player2(Cards).

verifica_resp("N", 1, 2):-
    player2().

verifica_resp("n", 1, 2):-
    player2(Cards).

verifica_resp("Y", 1, 2):-
    player1().


verifica_resp("n", 1, C):-

verifica_resp("N", 1, C):-

verifica_resp("Y", 1, C):-

verifica_resp("n", 1, C):-

verifica_resp("Y", 2, 1):-

verifica_resp("y", 2, 1):-

verifica_resp("N", 2, 1):-

verifica_resp("n", 2, 1):-


retira_carta(List, NewList, 1) :-
    random_member(Element, List),
    select(Element, List, NewList).


retira_carta(List, NewList, 2) :-
    random_member(Element, List),
    select(Element, List, NewList).

retira_carta(List, NewList, C) :-
    random_member(Element, List),
    select(Element, List, NewList).

lerString(E):- read_line_to_codes(user_input, X), atom_string(X, E).

menu:-
    nl,
    writeln('BEM VINDO AO BLACKJACK!'),
    writeln('Jogar com amigo (1)'),
    writeln('Jogar contra o computador (2)'),
    writeln('Instruções de como jogar (3)'),
    writeln('Sair (4)'), nl,
    writeln('O que deseja fazer? '), nl,
    lerString(Opcao),
    opcao(Opcao).

main:-
    menu().