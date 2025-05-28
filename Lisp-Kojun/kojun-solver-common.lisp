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


;------------------------------------------------------------------------------;
#|  SOLVER DE QUEBRA-CABEÇA - ALGORITMO DE BACKTRACKING

 1. INICIALIZAÇÃO:
    - Mapear todas as coordenadas de cada região do puzzle (defvar puzzle e defvar regions)
    - Criar uma tabela hash associando cada região às suas coordenadas (ex de hash: ID 1 (região 1), lista de pares (x y) contidos na reg. 1)

 2. ALGORITMO DE BACKTRACKING (função principal 'resolver'):
    Para cada posição (x,y) no puzzle de forma linha por linha:
      a) Se chegou ao final de todas as linhas: SUCESSO!
      b) Se chegou ao final da linha atual: vai para próxima linha
      c) Se a posição já tem um número: vai para próxima posição
      d) Se a posição está vazia (valor 0):
         - Calcula números disponíveis para esta posição
         - Tenta cada número disponível recursivamente:
           * Coloca o número na posição
           * Chama recursivamente para próxima posição
           * Se a recursão falha: remove o número e tenta o próximo
           * Se a recursão tem sucesso: retorna sucesso

 3. CÁLCULO DE NÚMEROS DISPONÍVEIS:
    Para cada posição vazia, os números disponíveis são determinados por:
    - Números já usados na mesma região (não podem ser repetidos)
    - Números adjacentes ortogonalmente (não podem ser iguais aos vizinhos)
    - Restrições verticais dentro da região (baseadas em vizinhos verticais)

 MÉTODO: Constraint Satisfaction Problem (CSP) com Backtracking
 - Usa propagação de restrições para calcular domínios válidos
 - Aplica backtracking quando uma tentativa falha
 - Verifica consistência local a cada passo
|#


;; Macro: executa forms apenas se test for falso
(defmacro a-menos-que* (teste &body formas) 
  `(if ,teste t (progn ,@formas)))

(defun obter-valor (matriz x y) (aref matriz y x))
(defun definir-valor-puzzle (x y valor) (setf (aref puzzle y x) valor))
(defun coordenadas-ortogonais (x y) `((,(1- x) ,y) (,(1+ x) ,y) (,x ,(1- y)) (,x ,(1+ y))))
(defun intervalo-de (u l) (loop for x from (1- u) above l collect x))
(defun definir-hash (chave valor dict) (setf (gethash chave dict) valor))
(defun regiao-de (x y) (obter-valor regions x y))
(defun dentro-dos-limites (x y) (and (>= x 0) (< x puzzle-w) (>= y 0) (< y puzzle-h)))
(defun coordenadas-da-regiao (x y) (gethash (regiao-de x y) region-coords))
(defun tamanho-da-regiao (x y) (length (coordenadas-da-regiao x y)))

(defun valor-no-puzzle (coord)
  (let ((x (nth 0 coord)) (y (nth 1 coord)))
    (if (dentro-dos-limites x y) (obter-valor puzzle x y) 0)))

(defun mesma-regiao-p (ax ay bx by) 
  (and (dentro-dos-limites ax ay) (dentro-dos-limites bx by) 
       (eq (regiao-de ax ay) (regiao-de bx by))))

(defun tentar-vizinho-regiao (ax ay bx by fallback)
  (if (mesma-regiao-p ax ay bx by) 
      (obter-valor puzzle bx by) 
      fallback))

(defun valores-ortogonais (x y) 
  (map 'list #'valor-no-puzzle (coordenadas-ortogonais x y)))

(defun valores-da-regiao (x y) 
  (map 'list #'valor-no-puzzle (coordenadas-da-regiao x y)))

(defun valores-verticais-validos (x y)
  (let ((a (tentar-vizinho-regiao x y x (1- y) (1+ (tamanho-da-regiao x y))))
        (b (tentar-vizinho-regiao x y x (1+ y) 0)))
    (intervalo-de a b)))

(defun numeros-disponiveis (x y)
  (let ((ortogonais (valores-ortogonais x y))
        (regiao (valores-da-regiao x y))
        (verticais (valores-verticais-validos x y)))
    (set-difference verticais (union ortogonais regiao))))

(defun mapear-coordenadas-regioes (x y) 
  (cond
    ((>= y puzzle-h) nil)
    ((>= x puzzle-w) (mapear-coordenadas-regioes 0 (1+ y)))
    (t (let ((regiao (regiao-de x y)))
         (if (gethash regiao region-coords)
             (push `(,x ,y) (gethash regiao region-coords))
             (definir-hash regiao `((,x ,y)) region-coords)))
       (mapear-coordenadas-regioes (1+ x) y))))

(defun tentar-valores-na-posicao (x y numeros)
  (when numeros
    (definir-valor-puzzle x y (first numeros))
    (a-menos-que* (resolver-proxima-posicao x y)
      (definir-valor-puzzle x y 0)
      (tentar-valores-na-posicao x y (rest numeros)))))

(defun resolver-proxima-posicao (x y)
  (let ((proximo-x (if (>= (1+ x) puzzle-w) 0 (1+ x)))
        (proximo-y (if (>= (1+ x) puzzle-w) (1+ y) y)))
    (resolver-puzzle proximo-x proximo-y)))

(defun resolver-puzzle (x y)
  (cond
    ((>= y puzzle-h) t)
    ((>= x puzzle-w) (resolver-puzzle 0 (1+ y)))
    (t (if (= 0 (obter-valor puzzle x y))
           (tentar-valores-na-posicao x y (numeros-disponiveis x y))
           (resolver-puzzle (1+ x) y)))))

(defun mostrar-puzzle ()
  (loop for y from 0 below puzzle-h do
    (loop for x from 0 below puzzle-w do
      (format t "~2d " (obter-valor puzzle x y)))
    (format t "~%")))

(defun resolver-e-mostrar ()
  (mapear-coordenadas-regioes 0 0)
  (if (resolver-puzzle 0 0)
      (progn
        (format t "Solução encontrada:~%")
        (mostrar-puzzle))
      (format t "Nenhuma solução encontrada~%")))

(resolver-e-mostrar)
