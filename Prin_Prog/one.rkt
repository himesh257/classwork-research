#lang racket
(define keys
  (lambda (w)
    (cond ((null? w) 5413)
          (else (+ (ctv(car w)) (* (keys(cdr w)) 29))))))

(define keys2
  (lambda (w)
    (cond ((null? w)5413)
          (else reduce(+ (keys2(cdr w)) 5413)))))

(define keys3
  (lambda (w p)
    (cond ((null? w) 5413 (null? p) 1111)
          (else + ctv(car w) reduce(* (keys(cdr w)) 29)))))

(define key2
	(lambda (w)
		(keys3 (reverse w))
	)	
)

(define reduce
  (lambda (op l id)
    (if (null? l)
        id
        (op (car l) (reduce op (cdr l) id)))))

(define ctv
  (lambda (x)
    (cond
      ((eq? x 'a) 1)
      ((eq? x 'b) 2)
      ((eq? x 'c) 3)
      ((eq? x 'd) 4)
      ((eq? x 'e) 5)
      ((eq? x 'f) 6)
      ((eq? x 'g) 7)
      ((eq? x 'h) 8)
      ((eq? x 'i) 9)
      ((eq? x 'j) 10)
      ((eq? x 'k) 11)
      ((eq? x 'l) 12)
      ((eq? x 'm) 13)
      ((eq? x 'n) 14)
      ((eq? x 'o) 15)
      ((eq? x 'p) 16)
      ((eq? x 'q) 17)
      ((eq? x 'r) 18)
      ((eq? x 's) 19)
      ((eq? x 't) 20)
      ((eq? x 'u) 21)
      ((eq? x 'v) 22)
      ((eq? x 'w) 23)
      ((eq? x 'x) 24)
      ((eq? x 'y) 25)
      ((eq? x 'z) 26))))

