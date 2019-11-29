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
    

menu1jogador:-
    writeln('Qual o seu nome jogador?'),
    lerString(Nome),
    format('~w se prepare, o jogo vai começar!', [Nome]), nl,
    verifica_resp_comp("y", Nome, "computador", 0, 0),
    nl.

menu2jogadores:-
    writeln('Qual o nome do primeiro jogador?'), nl,
    lerString(Nome1), nl,
    writeln('Qual o nome do segundo jogador?'), nl,
    lerString(Nome2), nl,
    format('~w e ~w se preparem, o jogo vai começar!', [Nome1, Nome2]), nl,
    verifica_resp1("y", Nome1, Nome2, 0, 0).
    


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

opcao(_):-
    writeln("Operação inválida, entre uma das opções abaixo:  "),
    menu.

verifica_resp_comp(Resposta, NomeJog, NomeComp,PontosJog, PontosComp):-
    write(Resposta),
    (   Resposta == "y"
        -> retira_carta_jog(NomeJog, NomeComp, PontosJog, PontosComp)
        ; Resposta == "Y"
        -> retira_carta_jog(NomeJog, NomeComp, PontosJog, PontosComp)
        ; Resposta == "n"
        -> retira_carta_comp(NomeComp,NomeJog, PontosComp, PontosJog)
        ; Resposta == "N"
        -> retira_carta_comp(NomeComp,NomeJog, PontosComp, PontosJog)
        ; writeln('Opção inválida, escolha entre y/n.'), nl,
        lerString(E), verifica_resp_comp(E, NomeJog, NomeComp,PontosJog, PontosComp)
        ).


verifica_resp1(Resposta, Nome1, Nome2,Pontos1, Pontos2):-
    write(Resposta),
    (   Resposta == "y"
        -> retira_carta1(Nome1, Nome2, Pontos1, Pontos2)
        ; Resposta == "Y"
        -> retira_carta1(Nome1,Nome2, Pontos1, Pontos2)
        ; Resposta == "n"
        -> retira_carta2(Nome2,Nome1, Pontos2, Pontos1)
        ; Resposta == "N"
        -> retira_carta2(Nome2,Nome1, Pontos2, Pontos1)
        ; writeln('Opção inválida, escolha entre y/n.'), nl,
        lerString(E), verifica_resp1(E, Nome1, Nome2,Pontos1, Pontos2)
        ).

verifica_resp2(Resposta, Nome2, Nome1, Pontos2, Pontos1):-
    (   Resposta == "y"
        -> retira_carta2(Nome2,Nome1, Pontos2, Pontos1)
        ; Resposta == "Y"
        -> retira_carta2(Nome2, Nome1, Pontos2, Pontos1)
        ; Resposta == "n"
        -> resultado_final(Nome1, Nome2, Pontos1, Pontos2)
        ; Resposta == "N"
        -> resultado_final(Nome1, Nome2, Pontos1, Pontos2)
        ; writeln('Opção inválida, escolha entre y/n.'), nl,
        lerString(E), verifica_resp2(E,Nome2,Nome1, Pontos2, Pontos1)
        ).


alteraCartas(Element):-
    cartas(Cartas),
    select(Element,Cartas ,NewCartas), nl,
    retract(cartas(Cartas)),
    assert(cartas(NewCartas)).


resultado_final(Nome1, Nome2, Pontos1, Pontos2) :-
    (   Pontos1 >  Pontos2 , Pontos1 =< 21 
        -> format('~w foi o vencedor', [Nome1]), nl, writeln("deseja jogar novamente? (y/n)"),
        lerString(E), verifica_resp3(E);
        Pontos2 > Pontos1 , Pontos2 =< 21
        ->  format('~w foi o vencedor', [Nome2]),nl, writeln("deseja jogar novamente? (y/n)"),
        lerString(E), verifica_resp3(E);
        Pontos2 < Pontos1 , Pontos1 > 21 , Pontos2 =< 21
        -> format('~w foi o vencedor', [Nome2]),nl, writeln("deseja jogar novamente? (y/n)"),
        lerString(E), verifica_resp3(E);
        Pontos1 < Pontos2 , Pontos2 > 21, Pontos1 =< 21
        -> format('~w foi o vencedor', [Nome1]),nl, writeln("deseja jogar novamente? (y/n)"),
        lerString(E), verifica_resp3(E);
        Pontos1 =< 21 , Pontos2 =< 21 , Pontos1 =:= Pontos2
        -> writeln('EMPATE'), nl,
        writeln("deseja jogar novamente?"),
        lerString(E), verifica_resp3(E);
        writeln('EMPATE'), nl,
        writeln("deseja jogar novamente?"),
        lerString(E), verifica_resp3(E)

    ).


verifica_resp3(Resposta) :- 
    (   Resposta == "y"
        -> menu
        ; Resposta == "Y"
        -> menu
        ; Resposta == "n"
        -> nl, writeln('OBRIGADO POR TER JOGADO BLACKJACK!')
        ; Resposta == "N"
        -> nl, writeln('OBRIGADO POR TER JOGADO BLACKJACK!')
        ; writeln('Opção inválida, escolha entre y/n.'), nl,
        lerString(E), verifica_resp3(E)
        ).

verifica21Jog(PontosJog,PontosComp, NomeJog, NomeComp):-
    PontosJog >= 21,
    retira_carta_comp(NomeComp,NomeJog,PontosComp,PontosJog).

verifica21Jog(PontosJog,PontosComp, NomeJog, NomeComp):-
    writeln("Deseja outra carta? (y/n)"),
    lerString(Str), nl,
    verifica_resp_comp(Str, NomeJog, NomeComp, PontosJog, PontosComp).

verifica21Comp(PontosComp,PontosJog,NomeComp,NomeJog) :-
    PontosComp >= 17,
    resultado_final(NomeJog, NomeComp, PontosJog, PontosComp).

verifica21Comp(PontosComp,PontosJog,NomeComp,NomeJog) :-
    retira_carta_comp(NomeComp,NomeJog, PontosComp, PontosJog).

verifica21(Pontos1, Pontos2, Nome1, Nome2):-
    Pontos1 >= 21,
    retira_carta2(Nome2, Nome1, Pontos2, Pontos1).

verifica21(Pontos1, Pontos2, Nome1, Nome2):-
    writeln("Deseja outra carta? (y/n)"),
    lerString(Str), nl,
    verifica_resp1(Str, Nome1, Nome2, Pontos1, Pontos2).

verifica21P2(Pontos2, Pontos1, Nome2, Nome1):-
    Pontos2 >= 21,
    resultado_final(Nome1, Nome2, Pontos1, Pontos2).

verifica21P2(Pontos2, Pontos1, Nome2, Nome1):-

    writeln("Deseja outra carta? (y/n) "), nl,
    lerString(Str),
    verifica_resp2(Str, Nome2, Nome1, Pontos2, Pontos1).


retira_carta_jog(NomeJog, NomeComp, PontosJog, PontosComp) :-
    cartas(List),
    random_member(Element, List),
    card(Element, Valor),
    soma_pontuacao(PontosJog, Valor, Soma),
    alteraCartas(Element), nl,
    format('~w, você tirou a carta ~w com pontuação de ~w.', [NomeJog, Element, Valor]), nl,
    format('~w, sua pontuação é de ~w pontos', [NomeJog,Soma]),nl, verifica21Jog(Soma, PontosComp, NomeJog, NomeComp).

retira_carta_comp(NomeComp, NomeJog, PontosComp, PontosJog) :-
    cartas(List),
    random_member(Element, List),
    card(Element, Valor),
    soma_pontuacao(PontosComp, Valor, Soma),
    alteraCartas(Element), nl,
    format('~w, você tirou a carta ~w com pontuação de ~w.', [NomeComp, Element, Valor]), nl,
    format('~w, sua pontuação é de ~w pontos', [NomeComp,Soma]),nl, verifica21Comp(Soma, PontosJog, NomeComp, NomeJog).

retira_carta1(Nome1,Nome2, Pontos1, Pontos2) :-
    cartas(List),
    random_member(Element, List),
    card(Element, Valor),
    soma_pontuacao(Pontos1, Valor, Soma),
    alteraCartas(Element), nl,
    format('~w, você tirou a carta ~w com pontuação de ~w.', [Nome1, Element, Valor]), nl,
    format('~w, sua pontuação é de ~w pontos', [Nome1,Soma]),nl, verifica21(Soma, Pontos2, Nome1, Nome2).



retira_carta2(Nome2,Nome1, Pontos2, Pontos1) :-
    cartas(List),
    random_member(Element, List),
    card(Element, Valor),
    soma_pontuacao(Pontos2, Valor, Soma),
    alteraCartas(Element), nl,
    format('~w, você tirou a carta ~w com pontuação de ~w.', [Nome2, Element, Valor]), nl,
    format('~w, sua pontuação é de ~w pontos', [Nome2,Soma]),nl, verifica21P2(Soma, Pontos1, Nome2, Nome1).

soma_pontuacao(Pontos, 1, Total) :-
    (Pontos =< 11
     -> Total is Pontos + 10;
     Total is Pontos + 1
    ).
soma_pontuacao(Pontos, Somador, Total):-
    Total is Pontos + Somador.


:- dynamic cartas/1. 

menu:-
    writeln('Jogar com amigo (1)'),
    writeln('Jogar contra o computador (2)'),
    writeln('Instruções de como jogar (3)'),
    writeln('Sair (4)'), nl,
    writeln('O que deseja fazer? '), nl,
    lerString(String), nl,
    opcao(String), nl.

main:-
    nl, writeln('BEM VINDO AO BLACKJACK!'),
    menu.
