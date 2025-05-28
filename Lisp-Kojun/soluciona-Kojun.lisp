;; Problem 1
#|(defvar puzzle-w 8)
(defvar puzzle-h 8)
(defvar region-coords (make-hash-table))
(defvar regions (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (a a b b c d e e)
   (a a f b g d d e)
   (f f f h g i j j)
   (k k k h g i i j)
   (l h h h h i i j)
   (l m n n n o p j)
   (m m m m q o o o)
   (r q q q q o s s)
)))
(defvar puzzle (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (0 0 0 0 0 0 0 0)
   (0 1 3 0 0 0 0 0)
   (0 0 0 0 0 3 0 0)
   (0 0 3 0 0 0 0 0)
   (0 5 0 3 0 0 0 0)
   (0 2 0 0 0 0 0 0)
   (0 0 0 0 0 0 3 0)
   (0 0 5 3 0 0 0 0)
)))|#

;; Problem 2
#|(defvar puzzle-w 6)
(defvar puzzle-h 6)
(defvar region-coords (make-hash-table))
(defvar regions (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (a d d d g k)
   (a e d g g g)
   (a a f g j j)
   (b c f h h j)
   (b c c i i j)
   (c c c i i i)
)))
(defvar puzzle (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (0 0 4 0 2 0)
   (0 0 3 0 0 0)
   (1 4 0 4 0 0)
   (0 5 0 0 0 2)
   (0 0 0 0 3 0)
   (6 2 0 2 0 5)
)))|#

;; Problem 3
#|(defvar puzzle-w 8)
(defvar puzzle-h 8)
(defvar region-coords (make-hash-table))
(defvar regions (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (a e b i i i i i)
   (a b b j i o i s)
   (b b b j k o p p)
   (b c c k k p p p)
   (c c g h l l r r)
   (d c c h h q q r)
   (d c h h m m r r)
   (d f f h n n n n)
)))
(defvar puzzle (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (0 0 0 6 5 3 0 0)
   (0 0 6 0 0 0 0 0)
   (2 4 0 0 3 0 0 3)
   (1 0 6 0 0 0 4 0)
   (0 3 0 6 0 0 0 4)
   (0 2 0 0 0 0 1 3)
   (0 0 5 0 0 1 0 0)
   (0 2 0 0 0 0 2 4)
)))|#

;; Problem 4
#|(defvar puzzle-w 12)
(defvar puzzle-h 17)
(defvar region-coords (make-hash-table))
(defvar regions (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (a e f j j p t u y y y y)
   (a f f g g p p u z z y y)
   (a f g g m m m u aa z z y)
   (a g g k k q q q aa aa aa ae)
   (a b g k k k r q aa aa af ae)
   (b b b h k r r v v ad ae ae)
   (b b h h n r r v ac ae ae ag)
   (c b h h h s r v v v ag ag)
   (c c i l l s r s ah ah w ai)
   (c c i l l s s s w w w ai)
   (c d i i i o o w w x aj ai)
   (d d i i o o o x x x aj aj)
)))
(defvar puzzle (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (0 0 0 2 0 2 0 0 1 0 0 0)
   (0 3 0 0 4 0 0 0 0 4 6 0)
   (0 0 6 3 0 0 2 0 0 0 0 3)
   (0 0 0 6 0 1 0 4 5 0 2 0)
   (0 0 2 0 0 2 0 0 0 0 0 4)
   (6 0 0 5 0 7 0 4 5 0 0 0)
   (4 0 6 0 0 3 0 0 0 5 0 0)
   (0 2 0 0 3 0 0 0 0 2 0 2)
   (0 0 7 0 0 0 0 6 0 0 2 0)
   (4 0 4 0 3 0 2 0 0 6 0 0)
   (0 3 0 0 6 0 5 0 0 3 0 0)
   (0 0 0 3 0 1 2 0 0 0 0 0)
)))|#

;; Problem 5
#|(defvar puzzle-w 10)
(defvar puzzle-h 10)
(defvar region-coords (make-hash-table))
(defvar regions (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (a a f f f f f p p p)
   (a a g f f l l l s s)
   (b b g k k l o o o u)
   (b c c h k k k o t u)
   (c c h h h k o o u u)
   (c c h i i i o q q q)
   (d d i i i m m m q v)
   (e d j j j m m m v v)
   (e d d j j n m r v v)
   (e e e e j n n r v v)
)))
(defvar puzzle (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (4 0 7 0 4 6 3 0 2 3)
   (0 0 0 1 0 4 0 2 0 2)
   (2 0 0 4 0 0 7 0 0 4)
   (0 6 0 0 0 6 0 4 0 3)
   (5 0 5 0 1 0 6 0 0 1)
   (4 1 0 3 0 4 2 0 0 0)
   (0 0 1 0 0 7 0 3 0 7)
   (5 3 0 5 6 0 5 0 6 3)
   (3 0 4 0 0 0 0 0 0 0)
   (1 0 6 4 3 0 2 0 4 0)
)))
|#

;; Problem 6
#|(defvar puzzle-w 12)
(defvar puzzle-h 12)
(defvar region-coords (make-hash-table))
(defvar regions (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (a a a a l l l v v v ad ad)
   (a a a l l q r r y aa aa af)
   (b b b i l r r r y aa aa af)
   (b c i i i i s w w z z af)
   (b c j i o o s s s ab z af)
   (c c f i o o s s s ab z ag)
   (c f f f p p t t z z z ag)
   (d d d f p p t t t t ae ae)
   (d d d f p m u u u t ae ae)
   (e g d m m m m m u u ae ah)
   (e e k k k k k m x ac ac ah)
   (e h h n n n n x x x ac ac)
)))
(defvar puzzle (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
   (2 0 6 3 5 4 0 0 3 0 0 2)
   (0 4 0 0 0 0 0 0 0 0 3 0)
   (0 1 0 4 2 3 0 4 0 0 1 0)
   (0 0 6 0 7 0 7 0 2 7 0 0)
   (0 2 0 0 0 2 5 4 0 0 0 0)
   (0 0 0 0 3 0 0 1 3 0 0 0)
   (4 2 0 6 5 0 5 0 0 2 0 0)
   (7 6 0 4 0 2 0 3 7 6 5 0)
   (0 0 0 0 0 0 0 4 0 0 0 0)
   (0 0 0 7 4 3 0 6 0 0 3 0)
   (0 0 3 0 0 5 0 0 0 0 0 0)
   (0 0 0 2 4 0 1 0 0 4 1 0)
)))|#

;; Problem 7
#|
(defvar puzzle-w 14)
(defvar puzzle-h 14)
(defvar region-coords (make-hash-table))
(defvar regions (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
  (1 1 1 1 1 18 18 24 29 29 29 36 36 44)
  (2 2 2 1 1 18 18 18 30 29 36 36 44 44)
  (2 3 2 10 10 10 10 21 30 29 37 37 37 44)
  (3 3 10 10 13 10 21 21 29 29 38 37 37 45)
  (3 3 4 13 13 13 22 25 25 25 38 37 37 45)
  (4 4 4 4 13 13 22 26 25 25 25 40 45 45)
  (5 5 4 4 13 19 19 26 26 32 33 41 41 45)
  (5 5 5 14 15 19 15 27 27 33 33 42 41 45)
  (6 8 8 11 15 15 15 27 27 33 33 42 42 45)
  (6 6 11 11 11 11 23 27 27 34 35 42 42 42)
  (6 6 11 11 16 17 23 20 31 35 35 35 46 42)
  (6 9 9 12 17 17 20 20 31 31 39 35 35 47)
  (7 9 9 12 12 20 20 20 31 31 39 39 43 43)
  (7 9 12 12 12 12 20 28 28 28 28 43 43 43)
)))
(defvar puzzle (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
  (3 1 2 6 0 4 2 0 5 0 2 4 0 4)
  (0 4 0 0 4 0 0 0 0 6 0 2 0 2)
  (0 0 0 0 3 5 4 0 0 3 0 7 6 1)
  (2 0 0 6 7 0 1 0 0 0 0 3 4 0)
  (1 0 4 3 0 6 0 0 6 0 0 0 0 0)
  (5 0 0 7 0 4 0 3 4 0 2 0 2 0)
  (0 4 1 6 0 0 3 0 0 0 0 0 0 4)
  (2 0 0 0 0 1 0 0 5 0 2 0 0 0)
  (6 2 0 0 4 0 0 3 0 3 0 0 6 0)
  (4 0 2 5 0 6 0 1 0 0 4 0 2 7)
  (0 3 0 0 0 0 0 0 5 3 0 0 0 4)
  (0 0 5 0 0 0 3 0 3 0 0 0 5 0)
  (0 0 0 0 3 0 0 5 0 1 2 0 0 0)
  (0 0 6 2 0 5 0 0 1 3 0 3 0 4)
)))
|#
;; Problem 8
#|
(defvar puzzle-w 17)
(defvar puzzle-h 17)

(defvar region-coords (make-hash-table))

(defvar regions
  (make-array `(,puzzle-w ,puzzle-h)
              :initial-contents '(
    (1  2  2 17 20 20 28 28 28 28 44 44 44 44 44 44 44)
    (2  2  2 17 17 20 28 31 31 38 38 39 49 49 49 49 61)
    (2  2 12 17 18 20 28 28 31 31 31 39 49 49 49 61 61)
    (3  3 12 12 18 26 29 29 31 31 39 39 50 50 50 61 62)
    (4  9 10 12 18 26 30 29 29 39 39 39 50 50 50 62 62)
    (4 10 10 12 18 21 30 30 32 40 40 40 40 55 55 62 62)
    (4  4 13 18 18 21 21 32 32 32 45 40 40 55 55 57 62)
    (5  4 13 14 21 21 21 33 36 32 45 47 51 51 55 57 57)
    (5  4 14 14 22 22 23 33 36 41 41 47 52 52 57 57 58)
    (5  6 14 14 23 23 23 33 36 42 42 47 47 52 52 57 58)
    (6  6  6 15 15 15 23 27 36 36 42 48 48 53 52 52 58)
    (7  6 15 15 15 27 27 27 36 42 42 48 53 53 58 58 58)
    (7  7 16 19 19 27 27 27 37 42 42 48 53 53 59 59 59)
    (7  7 16 16 19 19 24 34 37 37 46 46 54 54 59 60 59)
    (8  8 16 16 24 24 24 34 34 34 46 46 54 54 60 60 60)
    (8 11 16 16 24 24 25 35 35 43 43 46 54 56 56 60 63)
    (8  8  8  8 25 25 25 25 25 25 43 43 43 56 56 60 60)
)))

(defvar puzzle
  (make-array `(,puzzle-w ,puzzle-h)
              :initial-contents '(
    (0 3 0 0 0 0 5 1 0 3 1 0 7 3 0 4 2)
    (6 0 0 0 0 3 0 0 0 0 2 5 0 0 0 3 4)
    (5 0 0 1 5 0 2 0 0 5 0 0 4 1 0 0 0)
    (0 0 0 0 0 0 0 0 0 2 7 0 6 0 4 0 6)
    (6 0 0 4 3 0 0 2 0 0 0 0 2 1 0 4 0)
    (0 0 0 0 0 5 0 0 3 0 4 0 5 0 5 0 2)
    (1 0 0 0 0 3 0 0 0 5 0 3 0 0 4 0 0)
    (0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 2)
    (0 0 5 0 0 0 0 0 0 0 0 0 0 6 4 0 0)
    (0 4 0 0 4 0 3 0 3 0 5 0 2 0 2 0 0)
    (5 0 2 0 3 5 0 6 0 0 0 0 0 5 0 3 0)
    (0 0 4 2 0 0 7 0 0 7 0 0 3 0 6 5 0)
    (3 0 0 1 4 0 2 4 0 0 2 0 0 0 5 0 0)
    (0 1 0 6 0 2 0 0 0 3 0 5 0 0 3 6 2)
    (0 0 4 0 5 6 2 0 0 0 3 0 0 1 0 4 7)
    (2 0 2 0 4 0 0 0 1 0 0 1 0 4 0 0 0)
    (1 7 6 5 0 4 1 7 2 3 1 2 3 0 2 0 0)
)))
|#
;; SOLUCIONADOR DE QUEBRA-CABEÇAS - ALGORITMO DE RETROCESSO
;; Resolve puzzles com restrições de região, adjacência e ordenação vertical

;; Configuração do puzzle
(defvar puzzle-w 17)
(defvar puzzle-h 17)
(defvar mapa-regioes (make-hash-table))

(defvar regions (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
 (1 2 2 2 15 15 26 26 26 36 36 45 51 51 51 60 60)
 (2 2 2 15 15 15 27 31 26 36 36 45 45 45 51 51 60)
 (3 3 3 15 16 16 27 28 26 37 36 46 46 46 46 46 60)
 (3 3 3 3 16 20 27 28 28 37 37 47 47 47 47 46 63)
 (4 4 4 16 16 20 28 28 28 37 37 37 47 47 47 61 63)
 (4 4 4 11 16 16 29 29 29 38 38 38 38 38 38 56 63)
 (4 5 11 11 11 21 21 21 21 39 43 43 52 52 56 56 63)
 (5 5 5 17 17 17 17 21 33 33 43 40 52 55 55 55 63)
 (5 5 5 12 17 17 30 30 34 40 40 40 40 55 57 55 63)
 (6 6 12 12 12 12 30 30 34 34 34 34 48 55 55 62 62)
 (7 7 13 13 19 19 19 32 32 32 41 48 48 48 49 62 62)
 (8 7 7 13 19 19 19 32 35 41 41 41 48 49 49 62 62)
 (8 8 13 13 18 22 22 32 35 41 41 49 49 49 58 58 62)
 (8 8 14 14 18 22 23 23 23 42 44 49 53 53 58 58 58)
 (9 10 10 10 18 23 23 23 24 42 44 50 53 53 53 53 58)
 (9 10 9 18 18 24 24 24 24 24 44 44 44 53 59 59 54)
 (9 9 9 18 18 25 25 25 25 24 44 44 54 54 54 54 54)
)))

(defvar puzzle (make-array `(,puzzle-w ,puzzle-h) :initial-contents '(
 (0 3 5 6 0 0 1 2 0 2 0 3 0 4 0 0 4)
 (2 0 0 2 0 4 0 0 0 0 0 0 0 0 1 0 0)
 (7 6 5 0 7 0 0 4 0 0 3 0 0 0 6 5 2)
 (3 0 1 0 5 0 0 0 0 2 0 1 0 0 0 2 0)
 (0 7 0 2 0 0 3 0 0 0 5 0 0 0 5 0 0)
 (2 0 5 0 0 0 0 0 0 5 4 0 0 0 6 0 0)
 (1 0 0 3 1 0 0 0 5 0 0 0 0 1 3 0 0)
 (4 2 0 0 0 6 0 0 0 0 0 0 0 3 0 5 0)
 (3 0 6 2 0 3 0 0 4 0 5 0 0 2 0 4 0)
 (0 0 0 0 3 5 0 0 1 0 0 5 4 0 7 0 7)
 (3 0 5 0 6 0 2 0 4 0 3 0 0 0 0 0 6)
 (0 0 0 2 0 0 0 0 0 0 0 5 2 0 1 0 4)
 (0 4 0 0 0 0 0 0 0 0 1 0 7 0 3 4 0)
 (1 3 0 0 6 0 0 6 4 0 0 5 0 6 2 0 0)
 (6 0 0 1 0 2 0 0 7 0 4 0 0 4 0 0 0)
 (0 3 0 4 0 6 5 0 4 0 0 7 0 1 0 0 3)
 (0 2 0 0 2 0 4 0 1 2 0 5 4 5 0 2 0)
)))

;; ============================================================================
;; FUNÇÕES PRINCIPAIS DE RESOLUÇÃO
;; ============================================================================

;; Função principal: inicializa e executa a resolução completa
(defun resolver-tabuleiro ()
  "Coordena todo o processo de resolução: mapeia regiões e inicia backtracking."
  (construir-mapa-regioes 0 0)
  (if (explorar-tabuleiro 0 0)
      (progn
        (format t "Solução encontrada:~%")
        (exibir-tabuleiro))
      (format t "Nenhuma solução encontrada~%")))

;; Algoritmo principal de backtracking que percorre o tabuleiro
(defun explorar-tabuleiro (x y)
  "Navega pelo tabuleiro aplicando backtracking para encontrar solução válida."
  (cond
    ((>= y puzzle-h) t)                                    ; Chegou ao fim - sucesso!
    ((>= x puzzle-w) (explorar-tabuleiro 0 (1+ y)))       ; Fim da linha - próxima linha
    (t (if (= 0 (valor-em puzzle x y))                     ; Casa vazia precisa ser preenchida
           (experimentar-candidatos x y (candidatos-possiveis x y))
           (explorar-tabuleiro (1+ x) y)))))               ; Casa já preenchida - avança

;; Testa cada candidato válido usando backtracking
(defun experimentar-candidatos (x y candidatos)
  "Para cada candidato, tenta colocar no tabuleiro e verifica se leva à solução."
  (when candidatos
    (colocar-numero x y (first candidatos))
    ;; Se não conseguir resolver com este número, tenta o próximo
    (if (explorar-tabuleiro (1+ x) y)
        t  ; Sucesso - mantém o número
        (progn
          (colocar-numero x y 0)  ; Remove o número e tenta próximo candidato
          (experimentar-candidatos x y (rest candidatos))))))

;; Exibe o estado atual do tabuleiro de forma organizada
(defun exibir-tabuleiro ()
  "Apresenta o tabuleiro atual com formatação clara para visualização."
  (loop for y from 0 below puzzle-h do
    (loop for x from 0 below puzzle-w do
      (format t "~2d " (valor-em puzzle x y)))
    (format t "~%")))

;; ============================================================================
;; ANÁLISE DE CANDIDATOS E RESTRIÇÕES
;; ============================================================================

;; Determina quais números podem ser colocados em uma posição
(defun candidatos-possiveis (x y)
  "Calcula números válidos considerando restrições de região, adjacência e ordem vertical."
  (let ((vizinhos-ortogonais (numeros-vizinhos-ortogonais x y))
        (numeros-regiao (numeros-usados-regiao x y))
        (intervalo-vertical (faixa-vertical-permitida x y)))
    (set-difference intervalo-vertical (union vizinhos-ortogonais numeros-regiao))))

;; Calcula o intervalo de números permitidos pela restrição vertical
(defun faixa-vertical-permitida (x y)
  "Determina limites superior e inferior baseados em vizinhos verticais da mesma região."
  (let ((limite-superior (buscar-vizinho-regiao x y x (1- y) (1+ (tamanho-regiao x y))))
        (limite-inferior (buscar-vizinho-regiao x y x (1+ y) 0)))
    (gerar-intervalo limite-superior limite-inferior)))

;; Obtém números já utilizados nos vizinhos ortogonais
(defun numeros-vizinhos-ortogonais (x y)
  "Coleta valores das quatro direções cardeais (norte, sul, leste, oeste)."
  (map 'list #'valor-na-coordenada (gerar-coordenadas-ortogonais x y)))

;; Obtém números já utilizados na mesma região
(defun numeros-usados-regiao (x y)
  "Coleta todos os valores já preenchidos na região atual."
  (map 'list #'valor-na-coordenada (coordenadas-regiao x y)))

;; ============================================================================
;; UTILITÁRIOS DE DADOS E COORDENADAS
;; ============================================================================

;; Constrói o mapeamento de regiões para suas coordenadas
(defun construir-mapa-regioes (x y)
  "Percorre todo o tabuleiro criando listas de coordenadas por região."
  (cond
    ((>= y puzzle-h) nil)  ; Terminou de mapear
    ((>= x puzzle-w) (construir-mapa-regioes 0 (1+ y)))  ; Próxima linha
    (t (let ((id-regiao (identificar-regiao x y)))
         ;; Adiciona coordenada à lista da região correspondente
         (if (gethash id-regiao mapa-regioes)
             (push `(,x ,y) (gethash id-regiao mapa-regioes))
             (armazenar-hash id-regiao `((,x ,y)) mapa-regioes)))
       (construir-mapa-regioes (1+ x) y))))

;; Acessa valor em matriz bidimensional
(defun valor-em (matriz x y)
  "Extrai elemento da matriz na posição especificada (coluna x, linha y)."
  (aref matriz y x))

;; Modifica valor no tabuleiro principal
(defun colocar-numero (x y numero)
  "Atualiza a posição do tabuleiro com o número especificado."
  (setf (aref puzzle y x) numero))

;; Gera lista de coordenadas adjacentes ortogonalmente
(defun gerar-coordenadas-ortogonais (x y)
  "Produz as quatro coordenadas vizinhas (excluindo diagonais)."
  `((,(1- x) ,y)    ; Esquerda
    (,(1+ x) ,y)    ; Direita  
    (,x ,(1- y))    ; Cima
    (,x ,(1+ y))))  ; Baixo

;; Cria sequência numérica entre limites
(defun gerar-intervalo (superior inferior)
  "Gera lista de inteiros no intervalo aberto (inferior, superior)."
  (loop for x from (1- superior) above inferior collect x))

;; Armazena par chave-valor em tabela hash
(defun armazenar-hash (chave valor tabela)
  "Insere ou atualiza entrada na tabela hash especificada."
  (setf (gethash chave tabela) valor))

;; Identifica a região de uma coordenada
(defun identificar-regiao (x y)
  "Consulta a matriz de regiões para obter o ID da região."
  (valor-em regions x y))

;; Verifica se coordenada está dentro dos limites
(defun coordenada-valida-p (x y)
  "Confirma se a posição está dentro das dimensões do tabuleiro."
  (and (>= x 0) (< x puzzle-w)
       (>= y 0) (< y puzzle-h)))

;; Obtém todas as coordenadas de uma região
(defun coordenadas-regiao (x y)
  "Recupera lista completa de posições pertencentes à mesma região."
  (gethash (identificar-regiao x y) mapa-regioes))

;; Calcula quantidade de células em uma região
(defun tamanho-regiao (x y)
  "Conta o número total de posições na região especificada."
  (length (coordenadas-regiao x y)))

;; Obtém valor do tabuleiro para uma coordenada, com tratamento de limites
(defun valor-na-coordenada (coord)
  "Extrai valor do tabuleiro, retornando 0 para coordenadas inválidas."
  (let ((x (nth 0 coord))
        (y (nth 1 coord)))
    (if (coordenada-valida-p x y)
        (valor-em puzzle x y)
        0)))

;; Verifica se duas posições pertencem à mesma região
(defun mesma-regiao-p (ax ay bx by)
  "Compara IDs de região entre duas coordenadas válidas."
  (and (coordenada-valida-p ax ay)
       (coordenada-valida-p bx by)
       (eq (identificar-regiao ax ay) (identificar-regiao bx by))))

;; Busca valor de vizinho na mesma região ou retorna alternativa
(defun buscar-vizinho-regiao (ax ay bx by alternativa)
  "Se o vizinho estiver na mesma região, retorna seu valor; senão, usa alternativa."
  (if (mesma-regiao-p ax ay bx by)
      (valor-em puzzle bx by)
      alternativa))

;; Execução principal
(resolver-tabuleiro)