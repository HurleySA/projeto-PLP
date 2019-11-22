:- initialization main.
:- use_module(library(random)).
:- use_module(library(lists)).

lerString(E):- read_line_to_codes(user_input, X), atom_string(X, E).

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

cartas(["Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
        "Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
        "Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K",
        "Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]).
    

% menu1jogador:-
%     writeln('Qual o seu nome jogador?'),
%     lerString(Nome),
%     format('~w se prepare, o jogo vai começar!', [Nome]), nl,
%     writeln('Quer jogar? y/n'),
%     lerString(Str),
%     verifica_resp(Str, 1, c),
%     nl.

menu2jogadores:-
    writeln('Qual o nome do primeiro jogador?'), nl,
    lerString(Nome1), nl,
    writeln('Qual o nome do primeiro jogador?'), nl,
    lerString(Nome2), nl,
    format('~w e ~w se preparem, o jogo vai começar!', [Nome1, Nome2]), nl,
    format('~w, você quer tirar uma carta? y/n? ', [Nome1]), nl,
    lerString(Str),
    verifica_resp(Str, 1, 2).
    


menu_instrucoes:-
    writeln('BlackJack é um jogo que usa um baralho francês de 52 cartas(Cartas)para definir a pontuação.'),
    writeln('Um baralho francõs possui cartas(Cartas)de numeração de 2 a 10, onde no BlackJack equivale a uma pontuação proporcional a numeração.'),
    writeln('Também ha cartas(Cartas)especiais que são A, J, Q, K. As cartas(Cartas)J, Q e K valem 10 pontos, já a carta A pode assumir o valor de 1 ou de 11 dependendo da sua pontuação atual'),
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
    lerString(Escolhe),nl,
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

verifica_resp(Resposta, 1, 2):-
    write(Resposta),
    (   Resposta == "y"
        -> retira_carta(1)
        ; Resposta == "Y"
        -> retira_carta(1)
        ; Resposta == "n"
        -> retira_carta(2)
        ; Resposta == "N"
        -> retira_carta(2)
        ; writeln('Opção inválida, escolha entre y/n.'), nl,
        lerString(E), verifica_resp(E, 1, 2)
        ).

verifica_resp(Resposta, 2, 1):-
    (   Resposta == "y"
        -> retira_carta(2)
        ; Resposta == "Y"
        -> retira_carta(2)
        ; Resposta == "n"
        -> resultado_final(1,2)
        ; Resposta == "N"
        -> resultado_final(1,2)
        ; writeln('Opção inválida, escolha entre y/n.'), nl,
        lerString(E), verifica_resp(E,2,1)
        ).


% verifica_resp("n", 1, 2):-
%     player2(Cards).

% verifica_resp("N", 1, 2):-
%     player2(Cards).

% verifica_resp("n", 1, 2):-
%     player2(Cards).

% verifica_resp("Y", 1, 2):-
%     player1(Cards).

% verifica_resp("n", 1, C):-
%     playerpc(cartas(Cartas)).

% verifica_resp("N", 1, C):-
%     playerpc(cartas(Cartas)).

% verifica_resp("Y", 1, C):-
%     player1(cartas(Cartas)).


% verifica_resp("n", 1, C):-
%     playerpc(cartas(Cartas)).

% verifica_resp("Y", 2, 1):-
%     player2(cartas(Cartas).

% verifica_resp("y", 2, 1):-
%     player2(cartas(Cartas).

% verifica_resp("N", 2, 1):-

% verifica_resp("n", 2, 1):-


alteraCartas(Element):-
    cartas(Cartas),
    select(Element,Cartas ,NewCartas), nl,
    write(Element),nl,
    write(NewCartas),
    retract(cartas(Cartas)),
    assert(cartas(NewCartas)).
    

retira_carta(1) :-
    cartas(List),
    write(List),
    random_member(Element, List),
    alteraCartas(Element),
    write("~w, você quer tirar uma carta? y/n? "), nl,
    lerString(Str),
    verifica_resp(Str, 1, 2).

retira_carta(2) :-
    cartas(List),
    random_member(Element, List),
    alteraCartas(Element),
    write('~w, você quer tirar uma carta? y/n? '), nl,
    lerString(Str),
    verifica_resp(Str, 1, 2).

retira_carta(c) :-
    cartas(List),
    random_member(Element, List),
    alteraCartas(Element),
    verifica_resp("y", 1, 2).

:- dynamic cartas/1.

menu:-
    nl,
    writeln('BEM VINDO AO BLACKJACK!'),
    writeln('Jogar com amigo (1)'),
    writeln('Jogar contra o computador (2)'),
    writeln('Instruções de como jogar (3)'),
    writeln('Sair (4)'), nl,
    writeln('O que deseja fazer? '), nl,
    lerString(String), nl,
    opcao(String), nl.

main:-
    menu().