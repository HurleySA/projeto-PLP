import System.Random    -- Módulo para as funçoes de numeros aleatorios. 
                        -- Se nao rodar em alguma maquina roda 'cabal update' e 'cabal install random'

-- Funcao principal do programa. Executa a parte logica do main flow atraves de chamadas de funcoes secundarias
-- Trabalha a partir de chamadas recursivas, ja que Haskell nao possui loops
main :: IO ()
main = do
    -- Entrada do usuario para o menu inicial
    ent <- entradaUser ("\nBEM VINDO AO BLACKJACK!" ++ "\n\nJogar com amigo (1)" ++ "\nJogar contra o computador (2)" ++ "\nInstruções de como jogar (3)" ++ "\nSair (4)" ++ "\n\nO que deseja fazer?")
    case ent of -- switch case para as opcoes do menu
        "1" -> -- Jogar com amigo chamando a funcao "multiplayer"
            do 
                menuMultiPlayer -- Funcao para jogar com amigo
                return() -- Fecha a funcao apos toda a recursividade
        "2" -> -- Jogar contra o computador chamando a funcao "singleplayer"
            do 
                menuSinglePlayer -- Funcao para jogar contra o computador
                return() -- Fecha a funcao apos toda a recursividade
        "3" -> -- Ver as instrucoes chamando a funcao "instrucoes"
            do 
                putStrLn (instrucoes)
                main -- Chama novamente o "main" apos a execucao
                return() -- Fecha a funcao apos toda a recursividade
        "4" -> -- Sai do jogo
            do 
                return() -- Fecha a funcao apos toda a recursividade
        _ -> -- Qualquer outra entrada do usuario que nao seja "1", "2", "3" ou "4" sera ignorada e a funcao sera chamada novamente
            do 
                putStrLn ("\nOperação inválida, entre uma das opções abaixo:")
                main -- Chamada novamente o "main" apos a execucao
                return()  -- Fecha a funcao apos toda a recursividade


-- Esta eh uma funcao auxiliar destinada unicamente para a captacao de inputs dos usuarios
entradaUser :: String -> IO String
entradaUser ent = do -- "ent" eh o texto escrito como parametro
    putStrLn (ent) -- Printa o texto
    getLine -- Pega o input do usuario e o retorna na funcao

-- Funcao que mostra as instrucoes do jogo                
instrucoes :: String
instrucoes = "\nBlackJack eh um jogo que usa um baralho frances de 52 cartas para definir a pontuacao.\nUm baralho frances possui cartas de numeracao de 2 a 10, onde no BlackJack equivale a uma pontuacao proporcional a numeracao.\nTambem ha cartas especiais que sao A, J, Q, K. As cartas J, Q e K valem 10 pontos, ja a carta A pode assumir o valor de 1 ou de 11 dependendo da sua pontuacao atual.\nO jogador que juntar 21 pontos ou chegar mais proximo dos 21 eh o ganhador!\nO jogo começa dando uma carta inicial para o jogador e ele pode decidir entre pedir outra carta ou parar com a pontuacao que tem.\nCaso o jogador ultrapasse os 21 pontos ele perde, porem se o outro jogador tambem ultrapassar os 21 pontos entao eh declarado um empate."

-- Funcao para o modo de jogo SinglePlayer
menuSinglePlayer :: IO () 
menuSinglePlayer = do
    ent <- entradaUser("\nQual o nome do jogador?") -- O nome do primeiro jogador
    iniciaPartida ent "COMPUTADOR" -- Por default, o nome do segundo jogador eh COMPUTADOR

-- Funcao para o modo de jogo MultiPlayer
menuMultiPlayer :: IO () 
menuMultiPlayer = do 
    ent1 <- entradaUser("\nQual o nome do jogador 1?") -- O nome do jogador 1
    ent2 <- entradaUser("\nQual o nome do jogador 2?") -- O nome do jogador 2
    iniciaPartida ent1 ent2 -- Chamada da funcao para a logica do jogo

-- Funcao que dita a rotina principal do jogo
iniciaPartida :: String -> String -> IO () 
iniciaPartida nomeJogador1 nomeJogador2 = do -- Recebe como parametro os nomes dos players ("nomeJogador1", "nomeJogador2")
    
    --Rotina para o jogador um

    putStrLn ("\n--------------------------------------------------")
    putStrLn ((show $ nomeJogador1) ++ " e " ++ (show $ nomeJogador2) ++ " - Se preparem, o jogo vai comecar!")
    putStrLn ("\nVai comecar a partida de BlackJack!")
    putStrLn ("--------------------------------------------------")
    putStrLn ("\nSua vez de jogar " ++ (show $ nomeJogador1))
    pontuacao1 <- jogo [] 0 -- Invoca a funcao "jogo" para o jogador um, que retorna a pontuacao dele ("pontuacao1").
                            -- A lista vazia ("[]") eh a lista de cartas ja puxadas. E o "0" eh a pontuacao atual do jogador, que eh zero no comeco
    putStrLn ("\n--------------------------------------------------")
    putStrLn ("\nA pontuacao final de " ++ (show $ nomeJogador1) ++ " foi de " ++ (show $ pontuacao1) ++ " pontos")
    putStrLn ("\n--------------------------------------------------")
    
    -- Rotina para o jogador dois
    
    if (nomeJogador2 == "COMPUTADOR") -- Verifica se o jogador dois eh um player ou o COMPUTADOR
        then do
            putStrLn ("\nEh a vez do COMPUTADOR")
            pontuacao2 <- jogoComputador [] 0   -- Caso seja o COMPUTADOR, a funcao invocada eh a "jogoComputador".
                                                -- Esta funcao funciona como a "jogo", mas sem espaco para entrada de usuarios
            putStrLn ("\n--------------------------------------------------")
            putStrLn ("\nA pontuacao final do COMPUTADOR foi de " ++ (show $ pontuacao2) ++ " pontos")
            putStrLn ("\n--------------------------------------------------")
            putStrLn (mensagemFinal pontuacao1 pontuacao2 nomeJogador1 nomeJogador2)
        else do
            putStrLn ("\nSua vez de jogar " ++ (show $ nomeJogador2))
            pontuacao2 <- jogo [] 0 -- Caso seja um player, a rotina eh a mesma do jogador um
            putStrLn ("\n--------------------------------------------------")
            putStrLn ("\nA pontuacao final de " ++ (show $ nomeJogador2) ++ " foi de " ++ (show $ pontuacao2) ++ " pontos")
            putStrLn ("\n--------------------------------------------------")
            putStrLn (mensagemFinal pontuacao1 pontuacao2 nomeJogador1 nomeJogador2) -- Invoca a funcao para a mensagem final baseada nas pontuacoes

    putStrLn ("\n--------------------------------------------------")
    final <- entradaUser("\nVoce sera redirecionado para o menu agora. Aperte ENTER")   -- Isso soh serve para fechar a funcao do jogo com o consentimento do usuario.
                                                                                        -- Para nao ser uma transicao automatica para o menu principal
    main -- Chamada do "main" (menu principal)
    return ()   -- Fecha a funcao apos toda a recursividade do "main" chamado anteriormente que cria um novo flow dentro do anterior.
                -- Essa chamada de "return ()" garante que nao ficarao vestigios de funcoes abertas
    

-- Funcao que controla a recursividade do jogo para os usuarios
jogo :: [Int] -> Int -> IO Int
jogo lista pontos = do  -- Recebe uma lista de inteiros ("lista") que guarda as cartas ja puxadas pelo player.
                        -- E um inteiro ("pontos") que representa os pontos a cada puxada de carta.
                        -- Ambos os parametros sao mudados a cada puxada de carta

    if (pontos >= 21) -- Verificacao se o jogador ultrapassou ou atingiu os 21 pontos
        then do
            putStrLn ("\n--------------------------------------------------")
            putStrLn ("\nVoce ultrapassou os 21 pontos!")
            return (pontos) -- Caso o jogador tenha atingido a pontuacao limite (>= 21), a funcao retorna seus pontos

        else do -- Caso o jogador ainda nao tenha atingido o limite, a funcao pergunta se este deseja puxar uma carta
            ent <- entradaUser("\nDeseja puxar uma carta? s/n")
            if ((ent == "s") || (ent == "S")) -- O usuario opta por puxar uma carta
                then do
                    carta <- puxaCartaAleatoria lista -- Invocacao da funcao de puxar cartas recebendo a "lista" de cartas ja puxadas, retorna o valor da carta

                    let valor = traduzNum carta -- Traduz o valor da carta. J = 10, 9 = 9, etc

                    let pontuacao = verificaAs valor pontos     -- Esta funcao verifica se a carta puxada eh um AS 
                                                                -- e faz a devida mudanca de valor a mesma dependendo da pontuacao atual
                                                                -- associando tal valor a uma "variavel" (nao existe variavel em HAskell) 

                    let lista2 = pontuacao:lista -- Carta que foi puxada sendo adicionada a lista

                    putStrLn ("\nVoce puxou uma carta de valor:")
                    putStrLn (show $ pontuacao)
                    putStrLn ("\nVoce tem um total de: " ++ (show $ (sum lista2)) ++ " pontos")
                    
                    jogo2 <- jogo lista2 (sum lista2) -- Chamada recursiva com os parametros atualizados

                    return (jogo2) -- Retorno da funcao. Vai servir no retorno final que usa todos os retornos de todas as rotas percorridas na funcao
                else do
                    if ((ent == "n") || (ent == "N")) -- O usuario opta por terminar a sua rodada (antes de ultrapassar 21)
                        then do
                            return (pontos) -- Retorno da funcao sendo o retorno de todas as chamadas recursivas. Eh a pontuacao final
                    else do
                        putStrLn ("\nOpcao Invalida!") -- O usuario inseriu uma entrada invalida, o sistema so chama a funcao novamente com os mesmo parametros, sem mudanca

                        jogo2 <- jogo lista pontos -- Invocacao recursiva com os mesmos parametros

                        return (jogo2) -- Retorno da funcao. Vai servir no retorno final que usa todos os retornos de todas as rotas percorridas na funcao

-- Funcao que controla a recursividade do jogo para o COMPUTADOR
-- A diferenca entre essa funcao e a "jogo" eh que esta nao recebe entradas externas
jogoComputador :: [Int] -> Int -> IO Int    
jogoComputador lista pontos = do
    if (pontos >= 21)
        then do 
            putStrLn ("\n--------------------------------------------------")
            putStrLn ("\nO COMPUTADOR ultrapassou os 21 pontos!")
            return (pontos) -- Caso o COMPUTADOR tenha atingido a pontuacao limite (>= 21), a funcao retorna seus pontos
        else do
            if (pontos < 17)    -- Isso indica a regiao de conforto do COMPUTADOR. Enquanto sua pontuacao for menor que 17,
                                -- ele nao se sente "seguro" para continuar, e vai puxar uma carta. Ele para quando estiver entre 17 e 21 pontos

                then do -- Esta rotina eh a mesma de "jogo", mas input ou output externos
                    carta <- puxaCartaAleatoria lista
                    let valor = traduzNum carta
                    let pontuacao = verificaAs valor pontos
                    let lista2 = pontuacao:lista
                    jogo2 <- jogoComputador lista2 (sum lista2) -- Chamada recursiva com os parametros atualizados
                    return (jogo2) -- Retorno da funcao. Vai servir no retorno final que usa todos os retornos de todas as rotas percorridas na funcao
                else do
                    return (pontos) -- Retorno da funcao sendo o retorno de todas as chamadas recursivas. Eh a pontuacao final

-- Essa funcao serve para mostrar a mensagem final do game. Quem ganhou a partida e as pontuacoes dos jogadores
mensagemFinal :: Int -> Int -> String -> String -> String 
mensagemFinal pontuacao1 pontuacao2 nomeJogador1 nomeJogador2
                    |(pontuacao1 > 21) && (pontuacao2 > 21) = -- Ambos tiveram pontuacao acima de 21 pontos. Empate
                        "\nOs dois jogadores tiveram mais que 21 pontos. EMPATE!"

                    |((pontuacao1 > 21) && (pontuacao2 <= 21)) = -- O jogador um teve pontuacao acima de 21 pontos e o jogador dois nao. Jogador dois vence
                        if (nomeJogador2 == "COMPUTADOR") -- Jogador dois eh o COMPUTADOR
                            then "\nO COMPUTADOR ganhou! Ele tinha " ++ (show (pontuacao2)) ++ " e voce tinha " ++ (show (pontuacao1))
                            else "\nParabens " ++ nomeJogador2 ++ " voce ganhou essa partida! Voce tinha " ++ (show (pontuacao2)) ++ " e " ++ nomeJogador1 ++ " tinha " ++ (show (pontuacao1))

                    |((pontuacao1 <= 21) && (pontuacao2 > 21)) = -- O jogador dois teve pontuacao acima de 21 pontos e o jogador um nao. Jogador um vence
                        if (nomeJogador2 == "COMPUTADOR") -- Jogador dois eh o COMPUTADOR
                            then "\nVoce ganhou do COMPUTADOR! Ele tinha " ++ (show (pontuacao2)) ++ " e voce tinha " ++ (show (pontuacao1))
                            else "\nParabens " ++ nomeJogador1 ++ " voce ganhou essa partida! Voce tinha " ++ (show (pontuacao1)) ++ " e " ++ nomeJogador2 ++ " tinha " ++ (show (pontuacao2))

                    |(pontuacao1 < pontuacao2) = -- Ambos tem pontuacao abaixo de 21, mas o jogador um tem menos pontos que o jogador dois. Jogador dois vence
                        if (nomeJogador2 == "COMPUTADOR") -- Jogador dois eh o COMPUTADOR
                            then "\nO COMPUTADOR ganhou! Ele tinha " ++ (show (pontuacao2)) ++ " e voce tinha " ++ (show (pontuacao1))
                            else "\nParabens " ++ nomeJogador2 ++ " voce ganhou essa partida! Voce tinha " ++ (show (pontuacao2)) ++ " e " ++ nomeJogador1 ++ " tinha " ++ (show (pontuacao1))

                    |(pontuacao1 > pontuacao2) = -- Ambos tem pontuacao abaixo de 21, mas o jogador dois tem menos pontos que o jogador um. Jogador um vence
                        if (nomeJogador2 == "COMPUTADOR") -- Jogador dois eh o COMPUTADOR
                            then "\nVoce ganhou do COMPUTADOR! Ele tinha " ++ (show (pontuacao2)) ++ " e voce tinha " ++ (show (pontuacao1))
                            else "\nParabens " ++ nomeJogador1 ++ " voce ganhou essa partida! Voce tinha " ++ (show (pontuacao1)) ++ " e " ++ nomeJogador2 ++ " tinha " ++ (show (pontuacao2))

                    |otherwise = "\nOs dois jogadores possuem a mesma pontuacao. EMPATE!!" -- Ambos tem pontuacao abaixo de 21 e ambos tem a mesma pontuacao. Empate

-- Metodos de auxilio

-- Metodo que usa aleatoriedade para selecionar uma carta.
-- Recebe como parametro uma lista com as cartas ja ouxadas
puxaCartaAleatoria :: [Int] -> IO Int   
puxaCartaAleatoria [] = do -- Caso inde a lista recebida eh vazia

    num <- randomRIO (1,52::Int) -- Selecao aleatoria entre as 52 cartas do baralho

    return (num)    -- Retorno da funcao sendo o retorno de todas as chamadas recursivas. Eh o numero gerado
                    -- Como a lista eh vazia, qualquer carta puxada eh valida

puxaCartaAleatoria lista = do -- Caso a lista nao seja vazia

    num <- randomRIO (1,52::Int) -- Selecao aleatoria entre as 52 cartas do baralho

    if (num `elem` lista) -- Verificacao se a carta ja foi puxada
        then do
            cartaAleatoria2 <- puxaCartaAleatoria lista -- Chamada recursiva com os mesmos parametros. Isso se repete ate o numero aleatorio gerado nao pertencer a lista

            return (cartaAleatoria2) -- Retorno da funcao. Vai servir no retorno final que usa todos os retornos de todas as rotas percorridas na funcao
        else do 
            return (num) -- Retorno da funcao sendo o retorno de todas as chamadas recursivas. Eh o numero gerado
            
-- Funcao que verifica se a carta selecionada eh um AS
verificaAs :: Int -> Int -> Int 
verificaAs valor pontuacao = 
    if (valor == 1) -- Caso seja um AS

        then if (pontuacao > 10) -- Se a pontuacao atual for maior que 10, retorna 1. Caso nao seja, retorna 11
            then 1
            else 11
        else valor -- Caso nao seja um AS, retorna o valor inical recebido

-- Funcao para traduzir o valor da carta de acordo com o numero dela
traduzNum :: Int -> Int
traduzNum num = do
    if (num `elem` [1, 14 .. 52]) -- A carta eh um AS
        then 1
        else
            if (num `elem` [2, 15 .. 52]) -- A carta eh um 2
                then 2
                else
                    if (num `elem` [3, 16 .. 52]) -- A carta eh um 3
                        then 3
                        else
                            if (num `elem` [4, 17 .. 52]) -- A carta eh um 4
                                then 4
                                else 
                                    if (num `elem` [5, 18 .. 52]) -- A carta eh um 5
                                        then 5
                                        else
                                            if (num `elem` [6, 19 .. 52]) -- A carta eh um 6
                                                then 6
                                                else
                                                    if (num `elem` [7, 20 .. 52]) -- A carta eh um 7
                                                        then 7
                                                        else
                                                            if (num `elem` [8, 21 .. 52]) -- A carta eh um 8
                                                                then 8
                                                                else
                                                                    if (num `elem` [9, 22 .. 52]) -- A carta eh um 9
                                                                        then 9
                                                                        else 10 -- A carta eh um 10, um J, um Q ou um K

