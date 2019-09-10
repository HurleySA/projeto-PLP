#include <iostream>

using namespace std;

void menuDoisJogadores();
void menuUmJogador();
void menuInstrucoes();
void menuSaida();
void menuInicio();
int operacao;
string jogadorUm, jogadorDois;

int cartas[4][13] = {{1,2,3,4,5,6,7,8,9,10,10,10,10},
                    {1,2,3,4,5,6,7,8,9,10,10,10,10},
                    {1,2,3,4,5,6,7,8,9,10,10,10,10},
                    {1,2,3,4,5,6,7,8,9,10,10,10,10}};

int main()
{
    setlocale(LC_ALL,"");
    menuInicio();
    return 0;
}

void menuInicio(){
    cout << "BEM VINDO AO BLACKJACK!" << endl << endl;

    cout << "O que deseja fazer?" << endl;
    cout << "Jogar com amigo (1)" << endl;
    cout << "Jogar contra o computador (2)" << endl;
    cout << "Instruções de como jogar (3)" << endl;
    cout << "Sair (4)" << endl;

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
    cout << "Qual o nome do segundo jogador?" << endl;
    cin >> jogadorDois;
    cout << jogadorUm << " e " << jogadorDois << " o jogo vai começar!!" << endl;

}

void menuUmJogador(){

    cout << endl;
    cout << "Qual o seu nome do jogador?" << endl;
    cin >> jogadorUm;
    cout << jogadorUm << " contra o computador EITA CARAIIII!" << endl;
}

void menuInstrucoes(){
    cout << endl;
    cout << "BlackJack é um jogo que usa um baralho francês de 52 cartas para definir a pontuação." << endl;
    cout << "Um baralho francês possui cartas de numeração de 2 a 10, onde no BlackJack equivale a uma pontuação proporcional a numeração." << endl;
    cout << "Também há cartas especiais que são A, J, Q, K. As cartas J, Q e K valem 10 pontos, já a carta A pode assumir o valor de 1 ou de 11 dependendo da sua pontuação atual" << endl;
    cout << "O jogador que juntar 21 pontos ou chegar mais próximo dos 21 é o ganhador!!" << endl;
    cout << "O jogo começa dando uma carta inicial para o jogador e ele pode decidir entre pedir outra carta ou parar com a pontuação que tem." << endl;
    cout << "Caso o jogador ultrapasse os 21 pontos ele perde, porém se o outro jogador também ultrapassar os 21 pontos então é declarado um empate." << endl;

    cout << "Deseja voltar ao menu inicial? " << endl;


}

void menuSaida(){
    cout << endl;
    cout << "Obrigado por ter jogado BlackJack!" << endl;

}

