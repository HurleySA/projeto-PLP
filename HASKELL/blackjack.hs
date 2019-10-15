
main = do
    welcome
    putStrLn "\n      O que deseja fazer?\n"
    option <- getLine
    menu_escolhas option

menu_escolhas :: String -> IO()
menu_escolhas opcao = 
    if (read opcao) == 1 then do
         var <- menu2Players 
         putStrLn (fst(var))
         putStrLn (snd(var))
    else if (read opcao) == 2 then do 
        var <- menu1Player
        putStrLn(fst(var))
    else if (read opcao) == 3 then do
        menu_instrucoes
    else if (read opcao ) == 4 then do
        putStrLn ("OPT 4")
    else do
        putStrLn("Operação inválida, entre uma das opções abaixo:  \n\n")
        main

welcome :: IO()
welcome = putStrLn ("\n|BEM VINDO AO BLACK JACK!      |\n|Jogar com amigo (1)           |\n|Jogar contra o computador (2) |\n|Instruções de como jogar (3)  |\n|Sair (4)                      |")

menu2Players :: IO (String, String)
menu2Players = do
    putStrLn "Qual o nome do primeiro jogador?\n"
    player1 <- getLine
    putStrLn "Qual o nome do segundo jogador?\n"
    player2 <- getLine
    return (player1, player2)

menu1Player :: IO(String, String)
menu1Player = do
    putStrLn "Qual o seu nome, jogador?\n"
    player <- getLine
    return (player,"Computador")

menu_instrucoes :: IO()
menu_instrucoes = do
    putStrLn "\nBlackJack é um jogo que usa um baralho frances de 52 cartas para definir a pontuacao.\nUm baralho frances possui cartas de numeracao de 2 a 10, onde no BlackJack equivale a uma pontuacao proporcional a numeracao.\nTambem ha cartas especiais que sao A, J, Q, K. As cartas J, Q e K valem 10 pontos, ja a carta A pode assumir o valor de 1 ou de 11 dependendo da sua pontucao atual\nO jogador que juntar 21 pontos ou chegar mais próximo dos 21 é o ganhador!\nO jogo começa dando uma carta inicial para o jogador e ele pode decidir entre pedir outra carta ou parar com a pontuação que tem.\nCaso o jogador ultrapasse os 21 pontos ele perde, porém se o outro jogador também ultrapassar os 21 pontos então é declarado um empate.\n\n Digite Y para voltar ao menu inicial. \n"
    opcao <- getChar
    if (opcao == 'y' || opcao == 'Y')then do 
        main
    else do
        putStrLn "\nOpcao inválida.\n"
        menu_instrucoes

contador :: Int -> Int
contador k = k + contador

jogo :: Int -> [Int] -> Int -> Int -> IO String
jogo 1 = do
    jogada <- getLine
    cont <- contador
    cont jogada
    if(cont > 21)
        jogo cont
    else do
