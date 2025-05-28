;; =============================================================================
;; SOLVER DE QUEBRA-CABEÇA NUMÉRICO EM COMMON LISP
;; =============================================================================
;;
;; PSEUDOCÓDIGO DO ALGORITMO PRINCIPAL:
;; ====================================
;; 1. INICIALIZAÇÃO:
;;    - Mapear todas as coordenadas de cada região do puzzle
;;    - Criar uma tabela hash associando cada região às suas coordenadas
;;
;; 2. ALGORITMO DE BACKTRACKING (função principal 'resolver'):
;;    Para cada posição (x,y) no puzzle de forma linha por linha:
;;      a) Se chegou ao final de todas as linhas: SUCESSO!
;;      b) Se chegou ao final da linha atual: vai para próxima linha
;;      c) Se a posição já tem um número: vai para próxima posição
;;      d) Se a posição está vazia (valor 0):
;;         - Calcula números disponíveis para esta posição
;;         - Tenta cada número disponível recursivamente:
;;           * Coloca o número na posição
;;           * Chama recursivamente para próxima posição
;;           * Se a recursão falha: remove o número e tenta o próximo
;;           * Se a recursão tem sucesso: retorna sucesso
;;
;; 3. CÁLCULO DE NÚMEROS DISPONÍVEIS:
;;    Para cada posição vazia, os números disponíveis são determinados por:
;;    - Números já usados na mesma região (não podem ser repetidos)
;;    - Números adjacentes ortogonalmente (não podem ser iguais aos vizinhos)
;;    - Restrições verticais dentro da região (baseadas em vizinhos verticais)
;;
;; MÉTODO: Constraint Satisfaction Problem (CSP) com Backtracking
;; - Usa propagação de restrições para calcular domínios válidos
;; - Aplica backtracking quando uma tentativa falha
;; - Verifica consistência local a cada passo
;;
;; =============================================================================

;; MACROS E FUNÇÕES AUXILIARES BÁSICAS
;; ====================================

;; Macro personalizada: executa forms apenas se test for falso
;; Similar ao 'unless' padrão, mas com comportamento customizado
(defmacro a-menos-que* (teste &body formas) 
  `(if ,teste t (progn ,@formas)))

;; Acessa elemento da matriz nas coordenadas (x,y)
;; Nota: usa y como primeiro índice (linha) e x como segundo (coluna)
(defun obter-matriz (matriz x y) 
  (aref matriz y x))

;; Define valor em uma tabela hash
;; Encapsula a operação setf para tabelas hash
(defun definir-hash (chave valor dicionario) 
  (setf (gethash chave dicionario) valor))

;; Gera coordenadas dos 4 vizinhos ortogonais de (x,y)
;; Retorna lista com coordenadas: esquerda, direita, cima, baixo
(defun coords+ (x y) 
  `((,(1- x) ,y) (,(1+ x) ,y) (,x ,(1- y)) (,x ,(1+ y))))

;; Gera sequência de números de (u-1) até l (exclusivo)
;; Usado para criar ranges de números válidos
(defun intervalo (u l) 
  (loop for x from (1- u) above l collect x))

;; Define valor em uma posição específica do puzzle
;; Interface para modificar o puzzle principal
(defun definir-puzzle (x y valor) 
  (setf (aref puzzle y x) valor))

;; Obtém o identificador da região na posição (x,y)
;; Usado para determinar qual região uma célula pertence
(defun obter-regiao (x y) 
  (obter-matriz regions x y))

;; Verifica se coordenadas (x,y) estão dentro dos limites do puzzle
;; Previne acessos fora dos bounds da matriz
(defun dentro-limites (x y) 
  (and (>= x 0) (< x puzzle-w) (>= y 0) (< y puzzle-h)))

;; Obtém lista de todas as coordenadas de uma região
;; Usa a tabela hash de mapeamento região->coordenadas
(defun obter-coords-regiao (x y) 
  (gethash (obter-regiao x y) region-coords))

;; Calcula quantas células uma região possui
;; Útil para determinar limites de números válidos
(defun obter-tamanho-regiao (x y) 
  (length (obter-coords-regiao x y)))

;; Obtém valor do puzzle em uma coordenada, com verificação de limites
;; Retorna 0 se a coordenada estiver fora dos limites
(defun obter-puzzle (coord)
  (let ((x (nth 0 coord)) (y (nth 1 coord)))
    (if (dentro-limites x y) (obter-matriz puzzle x y) 0)))

;; Verifica se duas posições pertencem à mesma região
;; Essencial para aplicar restrições regionais
(defun na-mesma-regiao (ax ay bx by) 
  (and (dentro-limites ax ay) (dentro-limites bx by) 
       (eq (obter-regiao ax ay) (obter-regiao bx by))))

;; Obtém valor de vizinho na mesma região, ou fallback se não estiver
;; Usado para calcular restrições verticais dentro de regiões
(defun tentar-obter-vizinho-regiao (ax ay bx by fallback)
  (if (na-mesma-regiao ax ay bx by) 
      (obter-matriz puzzle bx by) 
      fallback))

;; =============================================================================
;; FUNÇÕES DE CÁLCULO DE RESTRIÇÕES
;; =============================================================================

;; Obtém valores dos 4 vizinhos ortogonais de uma posição
;; Usado para evitar números adjacentes iguais
(defun obter-ortogonais (x y) 
  (map 'list #'obter-puzzle (coords+ x y)))

;; Obtém todos os números já colocados na mesma região
;; Evita repetição de números dentro da região
(defun obter-numeros-regiao (x y) 
  (map 'list #'obter-puzzle (obter-coords-regiao x y)))

;; Calcula range de números válidos baseado em restrições verticais
;; Considera vizinhos verticais dentro da mesma região
(defun obter-numeros-verticais (x y)
  (let (
    ;; Vizinho de cima: se não existir, usa tamanho+1 como limite superior
    (a (tentar-obter-vizinho-regiao x y x (1- y) (1+ (obter-tamanho-regiao x y))))
    ;; Vizinho de baixo: se não existir, usa 0 como limite inferior
    (b (tentar-obter-vizinho-regiao x y x (1+ y) 0))
  )
  (intervalo a b)))

;; FUNÇÃO PRINCIPAL DE CÁLCULO DE NÚMEROS DISPONÍVEIS
;; Combina todas as restrições para determinar opções válidas
(defun obter-numeros-disponiveis (x y)
  (let (
    ;; Números dos vizinhos ortogonais (não podem ser iguais)
    (a (obter-ortogonais x y))
    ;; Números já usados na região (não podem repetir)
    (b (obter-numeros-regiao x y))
    ;; Range válido baseado em restrições verticais
    (c (obter-numeros-verticais x y))
  )
  ;; Retorna números do range c que não estão em a ou b
  (set-difference c (union a b))))

;; =============================================================================
;; ALGORITMO PRINCIPAL DE RESOLUÇÃO
;; =============================================================================

;; Mapeia todas as coordenadas por região
;; Constrói tabela hash região->lista_de_coordenadas
(defun mapear-regioes (x y) 
  (cond
    ;; Chegou ao final de todas as linhas
    ((>= y puzzle-h) nil)
    ;; Chegou ao final da linha atual, vai para próxima
    ((>= x puzzle-w) (mapear-regioes 0 (1+ y)))
    ;; Processa posição atual
    (t
      (let ((regiao (obter-regiao x y)))
        ;; Se região já existe no hash, adiciona coordenada
        (if (gethash regiao region-coords)
            (push `(,x ,y) (gethash regiao region-coords))
            ;; Se não existe, cria nova entrada
            (definir-hash regiao `((,x ,y)) region-coords)))
      ;; Continua para próxima posição
      (mapear-regioes (1+ x) y))))

;; Tenta colocar números de uma lista em uma posição
;; Implementa backtracking: tenta cada número e desfaz se falhar
(defun tentar-numeros (x y numeros)
  (when numeros
    ;; Coloca primeiro número da lista
    (definir-puzzle x y (first numeros))
    ;; Se não conseguir resolver a partir desta escolha
    (a-menos-que* (resolver-proximo x y)
      ;; Remove o número (backtrack) e tenta próximo
      (definir-puzzle x y 0)
      (tentar-numeros x y (rest numeros)))))

;; Continua resolução a partir da próxima posição após (x,y)
;; Gerencia transição entre colunas e linhas
(defun resolver-proximo (x y)
  "Continua resolvendo a partir da próxima posição após (x,y)"
  (let ((proximo-x (if (>= (1+ x) puzzle-w) 0 (1+ x)))
        (proximo-y (if (>= (1+ x) puzzle-w) (1+ y) y)))
    (resolver proximo-x proximo-y)))

;; FUNÇÃO PRINCIPAL DO SOLVER
;; Implementa busca em profundidade com backtracking
(defun resolver (x y)
  "Função principal de resolução - abordagem linha por linha"
  (cond
    ;; CASO BASE: chegou ao final de todas as linhas - SUCESSO!
    ((>= y puzzle-h) t)
    
    ;; Final da linha atual, vai para próxima linha
    ((>= x puzzle-w) (resolver 0 (1+ y)))
    
    ;; Posição atual precisa ser preenchida
    (t
      ;; Se posição está vazia (valor 0)
      (if (= 0 (obter-matriz puzzle x y))
          ;; Tenta todos os números disponíveis para esta posição
          (tentar-numeros x y (obter-numeros-disponiveis x y))
          ;; Se já tem número, vai para próxima posição
          (resolver (1+ x) y)))))

;; =============================================================================
;; FUNÇÕES DE INTERFACE E SAÍDA
;; =============================================================================

;; Imprime o puzzle de forma legível
;; Mostra matriz com formatação organizada
(defun imprimir-puzzle ()
  "Imprime o puzzle em formato legível"
  (loop for y from 0 below puzzle-h do
    (loop for x from 0 below puzzle-w do
      (format t "~2d " (obter-matriz puzzle x y)))
    (format t "~%")))

;; Função principal: resolve e exibe o resultado
;; Coordena todo o processo de resolução
(defun resolver-e-imprimir ()
  "Resolve o puzzle e imprime o resultado de forma organizada"
  ;; Primeiro mapeia todas as regiões
  (mapear-regioes 0 0)
  ;; Depois tenta resolver
  (if (resolver 0 0)
      (progn
        (format t "Solução encontrada:~%")
        (imprimir-puzzle))
      (format t "Nenhuma solução encontrada~%")))

;; Executa o solver
(resolver-e-imprimir)