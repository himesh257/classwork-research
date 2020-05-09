#lang racket

(require racket/trace)

; exercises.rkt with some answers
; see also the solutions provided at the end of the file


(define atom?
  (lambda (x)
    (not (pair? x))))


; numElementsLevel1: doesn't recurse into the list, so '(a b (c d)) -> 3, '(a b c) -> 3
(define numElementsLevel1 
  (lambda (l)
    (if (null? l)
        0
        (+ 1 (numElementsLevel1 (cdr l))))
 ))

; numElements: '(a b (c d)) -> 4, '(a b c) -> 3
(define numElements
  (lambda (l)
    (cond ((null? l) 0)
          ((list? (car l)) (+ (numElements (car l)) (numElements (cdr l)) )  )
          (else (+ 1 (numElements (cdr l))))
          )
    ))


; flatten: '(a (b c) d) -> '(a b c d)
(define flatten
  (lambda (l)
    (cond ((null? l) '())
          ((list? (car l)) (append (flatten (car l)) (flatten (cdr l))))
          (else (cons (car l) (flatten (cdr l))))
     )
    ))

; rev: '(a (b c) d) -> '(d (c b) a)
; Note: I spaced some of the parentheses out onto different lines and labelled them to make understanding the syntax easier
(define rev
  (lambda (l)
     (cond ((null? l) '())
           
          ; TODO: case where (car l) is itself a list

           (else ; i.e. (car l) is not a list
           (let
               ( ; begin definitions
                 (cdrrev (rev (cdr l)))
               ) ; close out the list of definitions

            ; body of let:

             ; wrap (car l) in a list and append that list to the recursive result of reversing the cdr of l
             (append cdrrev (list (car l))) 

           ) ; end of let
                  
          ) ; end else
     ) ; end cond
))



; double: '(a (b c) d) -> '(a a (b b c c) d d)
(define double
  (lambda (l)
    '() ; TODO
    ))

; delete: 'c '(a (b c) c d) -> '(a (b) d)
(define delete
  (lambda (x l)
    '() ; TODO
    ))

; minSquareVal: '(-5 3 -7 10 -11 8 7) -> 9
(define minSquareVal
  (lambda (l)
    '() ; TODO
    ))

; SOME SOLUTIONS (commented out)
;
;(define numElts
;  (lambda (l)
;    (cond ((null? l) 0)
;          ((atom? (car l)) (+ 1 (numElts (cdr l))))
;          (else (+ (numElts (car l)) (numElts (cdr l)))))))
;
;(define flatten
;  (lambda (l)
;    (cond ((null? l) '())
;          ((atom? (car l)) (cons (car l) (flatten (cdr l))))
;          (else (append (flatten (car l)) (flatten (cdr l)))))))
;
;(define delete
;  (lambda (x l)
;    (cond ((null? l) '())
;          ((atom? (car l)) (if (eq? (car l) x)
;                               (delete x (cdr l))
;                               (cons (car l) (delete x (cdr l)))))
;          (else (cons (delete x (car l)) (delete x (cdr l)))))))