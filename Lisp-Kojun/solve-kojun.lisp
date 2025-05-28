#| Início do script: invoca SBCL em modo script 
#!/bin/sh
exec sbcl --script "$0" "$@"
|#
;; Kojun Puzzle Parser and Solver - Fixed Variable Scoping

(defvar *puzzle*)
(defvar *puzzle-h*)
(defvar *puzzle-w*)
(defvar *region-coords*)
(defvar *regions*)

;; File parsing functions (keeping original - they seem to work)
(defun read-file-lines (filename)
  "Read a file into a list of lines."
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun trim-string (string)
  "Remove whitespace from beginning and end of string."
  (string-trim '(#\Space #\Tab #\Newline) string))

(defun split-string (string &optional (delimiter #\Space))
  "Split a string by delimiter."
  (loop for i = 0 then (1+ j)
        as j = (position delimiter string :start i)
        collect (subseq string i (or j (length string)))
        while j))

(defun parse-matrix-line (line)
  "Parse a line of matrix data into a list."
  (remove "" (mapcar #'trim-string (split-string line)) :test #'string=))

(defun parse-kojun-file (filename)
  "Parse a Kojun puzzle file into a list of problems."
  (let ((lines (mapcar #'trim-string (read-file-lines filename)))
        (problems nil)
        (current-problem nil)
        (current-section nil)
        (current-matrix nil))
    
    (dolist (line lines)
      (cond
        ((string= line "") nil)
        ((and (> (length line) 8) (string= (subseq line 0 8) "problem "))
         (when (and current-problem current-section)
           (setf (getf current-problem current-section) (reverse current-matrix))
           (push current-problem problems))
         (setf current-problem (list :number (parse-integer (subseq line 8))))
         (setf current-section nil)
         (setf current-matrix nil))
        ((and (> (length line) 2) 
              (char= (char line 0) #\[) 
              (char= (char line (1- (length line))) #\]))
         (when current-section
           (setf (getf current-problem current-section) (reverse current-matrix)))
         (setf current-section (intern (string-upcase (subseq line 1 (1- (length line))))))
         (setf current-matrix nil))
        ((and current-section (or (eq current-section 'PROBLEM) (eq current-section 'AREAS)))
         (let ((row (parse-matrix-line line)))
           (when row (push row current-matrix))))
        (t nil)))
    
    (when (and current-problem current-section)
      (setf (getf current-problem current-section) (reverse current-matrix))
      (push current-problem problems))
    
    (reverse problems)))

(defun convert-problem-to-arrays (problem)
  "Convert a parsed problem to puzzle and regions arrays."
  (let* ((problem-matrix (getf problem 'PROBLEM))
         (areas-matrix (getf problem 'AREAS))
         (height (length problem-matrix))
         (width (length (first problem-matrix)))
         (puzzle (make-array (list height width) :initial-element 0))
         (regions (make-array (list height width)))
         (area-numbers (make-hash-table))
         (area-to-letter (make-hash-table)))
    
    (dotimes (y height)
      (dotimes (x width)
        (let ((area-str (nth x (nth y areas-matrix))))
          (when area-str
            (setf (gethash (parse-integer area-str) area-numbers) t)))))
    
    (let ((sorted-areas (sort (loop for k being the hash-keys of area-numbers collect k) #'<))
          (letter-index 0))
      (dolist (area sorted-areas)
        (setf (gethash area area-to-letter) 
              (code-char (+ (char-code #\a) (mod letter-index 26))))
        (incf letter-index)))
    
    (dotimes (y height)
      (dotimes (x width)
        (let ((cell (nth x (nth y problem-matrix))))
          (when cell
            (setf (aref puzzle y x) 
                  (if (string= cell "-") 0 (parse-integer cell)))))))
    
    (dotimes (y height)
      (dotimes (x width)
        (let ((area-str (nth x (nth y areas-matrix))))
          (when area-str
            (let ((area-num (parse-integer area-str)))
              (setf (aref regions y x) (gethash area-num area-to-letter)))))))
    
    (list :width width :height height :puzzle puzzle :regions regions)))

(defun load-kojun-problem (filename problem-number)
  "Load a specific Kojun problem from a file."
  (let* ((problems (parse-kojun-file filename))
         (problem (find problem-number problems :key (lambda (p) (getf p :number))))
         (converted (when problem (convert-problem-to-arrays problem))))
    
    (when converted
      (setf *puzzle-w* (getf converted :width))
      (setf *puzzle-h* (getf converted :height))
      (setf *regions* (getf converted :regions))
      (setf *puzzle* (getf converted :puzzle))
      (setf *region-coords* (make-hash-table :test 'equal))
      t)))

;; FIXED SOLVER

(defun inbounds (x y) 
  (and (>= x 0) (< x *puzzle-w*) (>= y 0) (< y *puzzle-h*)))

(defun get-cell (x y)
  "Get puzzle cell value safely"
  (if (inbounds x y) (aref *puzzle* y x) 0))

(defun set-cell (x y value)
  "Set puzzle cell value safely"
  (when (inbounds x y)
    (setf (aref *puzzle* y x) value)))

(defun get-region (x y)
  "Get region letter for cell"
  (if (inbounds x y) (aref *regions* y x) nil))

(defun same-region-p (x1 y1 x2 y2)
  "Check if two cells are in the same region"
  (and (inbounds x1 y1) (inbounds x2 y2)
       (equal (get-region x1 y1) (get-region x2 y2))))

(defun get-region-cells (x y)
  "Get all cells in the same region as (x,y)"
  (let ((region (get-region x y))
        (cells nil))
    (when region
      (dotimes (row *puzzle-h*)
        (dotimes (col *puzzle-w*)
          (when (equal (get-region col row) region)
            (push (list col row) cells)))))
    cells))

(defun get-orthogonal-neighbors (x y)
  "Get values of orthogonal neighbors (not in same region)"
  (let ((neighbors nil))
    (dolist (dir '((-1 0) (1 0) (0 -1) (0 1)))
      (let ((nx (+ x (first dir)))
            (ny (+ y (second dir))))
        (when (and (inbounds nx ny) 
                   (not (same-region-p x y nx ny))
                   (> (get-cell nx ny) 0))
          (push (get-cell nx ny) neighbors))))
    neighbors))

(defun get-region-values (x y)
  "Get all non-zero values in the same region"
  (let ((cells (get-region-cells x y))
        (values nil))
    (dolist (cell cells)
      (let ((val (get-cell (first cell) (second cell))))
        (when (> val 0)
          (push val values))))
    values))

(defun get-vertical-constraint (x y)
  "Get valid numbers based on vertical ordering constraint"
  (let* ((region-size (length (get-region-cells x y)))
         (upper-bound (1+ region-size))
         (lower-bound 0))
    
    ;; Check cell above in same region
    (when (same-region-p x y x (1- y))
      (let ((above-val (get-cell x (1- y))))
        (when (> above-val 0)
          (setf upper-bound above-val))))
    
    ;; Check cell below in same region  
    (when (same-region-p x y x (1+ y))
      (let ((below-val (get-cell x (1+ y))))
        (when (> below-val 0)
          (setf lower-bound below-val))))
    
    ;; Return valid range
    (loop for i from (1+ lower-bound) below upper-bound collect i)))

(defun get-valid-numbers (x y)
  "Get all valid numbers for cell (x,y)"
  (let ((region-size (length (get-region-cells x y))))
    (when (> region-size 0)
      (let ((all-numbers (loop for i from 1 to region-size collect i))
            (used-in-region (get-region-values x y))
            (used-orthogonal (get-orthogonal-neighbors x y))
            (vertical-valid (get-vertical-constraint x y)))
        
        ;; Remove used numbers and apply constraints
        (set-difference 
          (intersection all-numbers vertical-valid)
          (union used-in-region used-orthogonal))))))

(defun find-next-empty-cell ()
  "Find the next empty cell to fill"
  (dotimes (y *puzzle-h*)
    (dotimes (x *puzzle-w*)
      (when (= (get-cell x y) 0)
        (return-from find-next-empty-cell (list x y)))))
  nil)

(defun solve-puzzle ()
  "Main solving function using backtracking"
  (let ((empty-cell (find-next-empty-cell)))
    (if (null empty-cell)
        t  ; No empty cells = solved!
        (let ((x (first empty-cell))
              (y (second empty-cell)))
          (dolist (num (get-valid-numbers x y))
            (set-cell x y num)
            (when (solve-puzzle)
              (return-from solve-puzzle t))
            (set-cell x y 0))  ; Backtrack
          nil))))  ; No valid number worked

;; Initialize region mapping
(defun map-regions ()
  "Map all regions for quick lookup"
  (clrhash *region-coords*)
  (dotimes (y *puzzle-h*)
    (dotimes (x *puzzle-w*)
      (let ((region (get-region x y)))
        (when region
          (if (gethash region *region-coords*)
              (push (list x y) (gethash region *region-coords*))
              (setf (gethash region *region-coords*) (list (list x y)))))))))

;; Utility functions
(defun print-puzzle ()
  "Print the current puzzle state."
  (format t "~%Puzzle (~Ax~A):~%" *puzzle-w* *puzzle-h*)
  (dotimes (y *puzzle-h*)
    (dotimes (x *puzzle-w*)
      (format t "~A " (get-cell x y)))
    (format t "~%")))

(defun print-regions ()
  "Print the regions."
  (format t "~%Regions:~%")
  (dotimes (y *puzzle-h*)
    (dotimes (x *puzzle-w*)
      (format t "~A " (get-region x y)))
    (format t "~%")))

(defun solve-and-print (filename problem-number)
  "Load, solve and print a Kojun puzzle."
  (format t "~%Loading problem ~A from file ~A...~%" problem-number filename)
  (if (load-kojun-problem filename problem-number)
      (progn
        (format t "Problem loaded successfully!~%")
        (print-puzzle)
        (print-regions)
        (map-regions)
        (format t "~%Solving...~%")
        (if (solve-puzzle)
            (progn
              (format t "~%*** SOLUTION FOUND! ***~%")
              (print-puzzle))
            (format t "~%No solution exists.~%")))
      (format t "Failed to load problem ~A~%" problem-number)))

;; Example usage:
(solve-and-print "kojun.txt" 4)