#include <iostream>
#include <stdlib.h>
#include <time.h>

using namespace std;

void menuDoisJogadores();
void menuUmJogador();
void menuInstrucoes();
void menuSaida();
void menuInicio();
void iniciaJogo(string nome1, string nome2);
void geraPontuacao(int pontuacaoTotal);
int  verificaAs(int numeroGerado, int pontuacaoTotal);
int operacao, pontosJog1, pontosJog2;
string jogadorUm, jogadorDois;

int cartas[4][13] = {{1,2,3,4,5,6,7,8,9,10,10,10,10},
                    {1,2,3,4,5,6,7,8,9,10,10,10,10},
                    {1,2,3,4,5,6,7,8,9,10,10,10,10},
                    {1,2,3,4,5,6,7,8,9,10,10,10,10}};

int main()
{
    setlocale(LC_ALL,"");
    srand (time(NULL));
    menuInicio();
    return 0;
}

void menuInicio(){
    cout << "BEM VINDO AO BLACKJACK!" << endl << endl;

    cout << "Jogar com amigo (1)" << endl;
    cout << "Jogar contra o computador (2)" << endl;
    cout << "Instruções de como jogar (3)" << endl;
    cout << "Sair (4)" << endl;
    cout << "O que deseja fazer? ";
    cin >> operacao;

    switch(operacao){
        case 1:
            menuDoisJogadores();
            break;
        case 2:
            menuUmJogador();
            break;
        case 3:
            menuInstrucoes();
            break;
        case 4:
            menuSaida();
            break;
        default:
            cout << "Operação inválida" << endl;

    }
}

void menuDoisJogadores(){

    cout << endl;
    cout << "Qual o nome do primeiro jogador?" << endl;
    cin >> jogadorUm;
    cout << endl;
    cout << "Qual o nome do segundo jogador?" << endl;
    cin >> jogadorDois;
    cout << endl;
    cout << jogadorUm << " e " << jogadorDois << " se preparem o jogo vai começar!!" << endl;
    iniciaJogo(jogadorUm, jogadorDois);

}

void menuUmJogador(){

    cout << endl;
    cout << "Qual o seu nome do jogador?" << endl;
    cin >> jogadorUm;
    jogadorDois = "computador";
    cout << jogadorUm << " contra o " << jogadorDois <<" vai começar!! EITA CARAIIII!" << endl;
    iniciaJogo(jogadorUm, jogadorDois);

}

void menuInstrucoes(){
    cout << endl;
    cout << "BlackJack é um jogo que usa um baralho francês de 52 cartas para definir a pontuação." << endl;
    cout << "Um baralho francês possui cartas de numeração de 2 a 10, onde no BlackJack equivale a uma pontuação proporcional a numeração." << endl;
    cout << "Também há cartas especiais que são A, J, Q, K. As cartas J, Q e K valem 10 pontos, já a carta A pode assumir o valor de 1 ou de 11 dependendo da sua pontuação atual" << endl;
    cout << "O jogador que juntar 21 pontos ou chegar mais próximo dos 21 é o ganhador!!" << endl;
    cout << "O jogo começa dando uma carta inicial para o jogador e ele pode decidir entre pedir outra carta ou parar com a pontuação que tem." << endl;
    cout << "Caso o jogador ultrapasse os 21 pontos ele perde, porém se o outro jogador também ultrapassar os 21 pontos então é declarado um empate." << endl;

    cout << "Digite Y para voltar ao menu inicial?" << endl;
    string escolha;
    cin >> escolha;

     if(escolha == "Y" || escolha == "y"){
        menuInicio();
     }



}

void menuSaida(){
    cout << endl;
    cout << "Obrigado por ter jogado BlackJack!" << endl;

}

void iniciaJogo(string nome1, string nome2){
    string escolha;
    cout << endl;
    cout << "Sua vez de jogar " << jogadorUm << endl;
    RETORNO1:;
    int i = rand()%3;
    int j = rand()%13;
    int pontoGerado = cartas[i][j];
    pontoGerado = verificaAs(pontoGerado, pontosJog1);
    pontosJog1 += pontoGerado;
    cout << endl;
    cout << jogadorUm << " você tem um total de: " << pontosJog1 << " pontos" << endl;
    cout << jogadorUm << " quer pedir outra carta ? Y/N " << endl;

    cin >> escolha;

    if(escolha == "Y" || escolha == "y"){
        goto RETORNO1;
    }else{
        cout << "Sua vez de jogar " << jogadorDois << endl;
        RETORNO2:;
        i = rand()%3;
        j = rand()%13;
        pontoGerado = cartas[i][j];
        pontoGerado = verificaAs(pontoGerado, pontosJog2);
        pontosJog2 += pontoGerado;
        cout << endl;
        cout << jogadorDois << " você tem um total de:" << pontosJog2 << " pontos" << endl;
        cout << jogadorDois << " quer pedir outra carta ? Y/N" << endl;

        cin >> escolha;

        if(escolha == "Y" || escolha == "y"){
            goto RETORNO2;
        }else{
            if(pontosJog1 > 21 && pontosJog2 > 21 ){
                cout << "empate" << endl;
            }else if(pontosJog1 > 21 && pontosJog2 <= 21){
                cout << "Parabéns " << jogadorDois << " você ganhou essa desgraça! Você tinha " << pontosJog2 << " e o outro jogador tinha " << pontosJog1 << endl;
            }else if(pontosJog1 <= 21 && pontosJog2 > 21){
                cout << "Parabéns " << jogadorUm << " você ganhou essa desgraça! Você tinha " << pontosJog1 << " e o outro jogador tinha " << pontosJog2  << endl;
            }else if(pontosJog2 < pontosJog1){
                cout << "Parabéns " << jogadorUm << " você ganhou essa desgraça! Você tinha " << pontosJog1 << " e o outro jogador tinha " << pontosJog2  << endl;
            }else if(pontosJog1 < pontosJog2){
                cout << "Parabéns " << jogadorDois << "você ganhou essa desgraça! Você tinha " << pontosJog2 << " e o outro jogador tinha " << pontosJog1  << endl;
            }else{
                cout << "empate" << endl;
            }
        }
    }

}

int verificaAs(int numeroGerado, int pontuacaoTotal){
    int saida;
    if(numeroGerado == 1){
        if(pontuacaoTotal > 10){
           saida = 1;
        }else{
            saida = 11;
        }
    }else{
        saida = numeroGerado;
    }

    return saida;
}

