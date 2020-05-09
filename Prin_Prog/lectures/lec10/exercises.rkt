#lang racket

(require racket/trace)

(define atom?
  (lambda (x)
    (not (pair? x))))

; numElements: '(a b (c d)) -> 4, '(a b c) -> 3
(define numElements
  (lambda (l)
    '() ; TODO
    ))

; flatten: '(a (b c) d) -> '(a b c d)
(define flatten
  (lambda (l)
    '() ; TODO
    ))

; rev: '(a (b c) d) -> '(d (c b) a)
(define rev
  (lambda (l)
    '() ; TODO
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
